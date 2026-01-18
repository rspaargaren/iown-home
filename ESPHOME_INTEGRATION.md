# ESPHome Integration Plan für iown-homecontrol

## Übersicht

Dieses Dokument beschreibt die Integration des iown-homecontrol Projekts als ESPHome Custom Component für die nahtlose Steuerung von Velux/Somfy Geräten über Home Assistant.

## Architektur

### Component-Struktur

```
components/iohomecontrol/
├── __init__.py                 # ESPHome Component Registration (Python)
├── cover.py                    # Cover Platform für Rollos/Fenster
├── sensor.py                   # Sensor Platform für RSSI/Status
├── binary_sensor.py            # Binary Sensor für Pairing-Status
├── iohomecontrol.h             # Haupt-Component Header
├── iohomecontrol.cpp           # Haupt-Component Implementation
├── iohomecontrol_cover.h       # Cover-spezifischer Header
├── iohomecontrol_cover.cpp     # Cover-Implementation
├── iohome_protocol.h           # Protocol Layer (aus src/)
└── iohome_protocol.cpp         # Protocol Implementation
```

## Beispiel-Konfiguration

### Basis-Setup

```yaml
# velux-bridge.yaml
esphome:
  name: velux-bridge
  platform: ESP32
  board: heltec_wifi_lora_32_V2
  platformio_options:
    lib_deps:
      - jgromes/RadioLib

wifi:
  ssid: !secret wifi_ssid
  password: !secret wifi_password

api:
  encryption:
    key: !secret api_encryption_key

ota:

logger:
  level: DEBUG

external_components:
  - source:
      type: local
      path: components
    components: [ iohomecontrol ]

# io-homecontrol Radio Configuration
iohomecontrol:
  cs_pin: GPIO18
  irq_pin: GPIO26
  rst_pin: GPIO14
  frequency: 868.95  # MHz

  # Optional: System Key (nach Pairing)
  system_key: "E994BACFE6BED7667630EAE475BAAE95"

  # Optional: Node ID dieses Controllers
  node_id: "0xABCDEF"

# Cover-Geräte definieren
cover:
  - platform: iohomecontrol
    name: "Dachfenster Schlafzimmer"
    node_id: "0x646575"
    device_type: window_opener
    mode: 1W  # oder 2W

  - platform: iohomecontrol
    name: "Rollo Wohnzimmer"
    node_id: "0x123456"
    device_type: roller_shutter
    mode: 1W

# Sensor für RF-Qualität
sensor:
  - platform: iohomecontrol
    rssi:
      name: "io-homecontrol RSSI"
    snr:
      name: "io-homecontrol SNR"

# Binary Sensor für Status
binary_sensor:
  - platform: iohomecontrol
    name: "io-homecontrol Connected"
    device_class: connectivity
```

### Erweiterte Konfiguration mit 2W Mode

```yaml
iohomecontrol:
  cs_pin: GPIO18
  irq_pin: GPIO26
  rst_pin: GPIO14

  # 2W Mode mit Frequency Hopping
  mode: 2W
  channels:
    - 868.25  # Channel 1
    - 868.95  # Channel 2 (Primary)
    - 869.85  # Channel 3
  hop_interval: 2.7  # ms

  system_key: "E994BACFE6BED7667630EAE475BAAE95"
  node_id: "0xABCDEF"

  # Pairing Mode aktivieren
  pairing_mode: false

cover:
  - platform: iohomecontrol
    name: "Velux Fenster"
    node_id: "0x646575"
    device_type: window_opener
    mode: 2W

    # Optionale Position-Callbacks
    on_open:
      - logger.log: "Fenster wird geöffnet"
    on_close:
      - logger.log: "Fenster wird geschlossen"
```

## Python Component Definition

### `components/iohomecontrol/__init__.py`

```python
import esphome.codegen as cg
import esphome.config_validation as cv
from esphome import pins
from esphome.const import (
    CONF_ID,
    CONF_FREQUENCY,
    CONF_MODE,
)

DEPENDENCIES = ["spi"]
AUTO_LOAD = ["cover", "sensor", "binary_sensor"]

CONF_CS_PIN = "cs_pin"
CONF_IRQ_PIN = "irq_pin"
CONF_RST_PIN = "rst_pin"
CONF_NODE_ID = "node_id"
CONF_SYSTEM_KEY = "system_key"
CONF_CHANNELS = "channels"
CONF_HOP_INTERVAL = "hop_interval"
CONF_PAIRING_MODE = "pairing_mode"

iohomecontrol_ns = cg.esphome_ns.namespace("iohomecontrol")
IoHomeControlComponent = iohomecontrol_ns.class_(
    "IoHomeControlComponent", cg.Component
)

CONFIG_SCHEMA = cv.Schema(
    {
        cv.GenerateID(): cv.declare_id(IoHomeControlComponent),
        cv.Required(CONF_CS_PIN): pins.gpio_output_pin_schema,
        cv.Required(CONF_IRQ_PIN): pins.gpio_input_pin_schema,
        cv.Required(CONF_RST_PIN): pins.gpio_output_pin_schema,
        cv.Optional(CONF_FREQUENCY, default=868.95): cv.float_range(
            min=868.0, max=870.0
        ),
        cv.Optional(CONF_MODE, default="1W"): cv.one_of("1W", "2W", upper=True),
        cv.Optional(CONF_NODE_ID): cv.hex_uint32_t,
        cv.Optional(CONF_SYSTEM_KEY): cv.string,
        cv.Optional(CONF_CHANNELS): cv.ensure_list(cv.float_),
        cv.Optional(CONF_HOP_INTERVAL, default=2.7): cv.float_,
        cv.Optional(CONF_PAIRING_MODE, default=False): cv.boolean,
    }
).extend(cv.COMPONENT_SCHEMA)


async def to_code(config):
    var = cg.new_Pvariable(config[CONF_ID])
    await cg.register_component(var, config)

    cs = await cg.gpio_pin_expression(config[CONF_CS_PIN])
    cg.add(var.set_cs_pin(cs))

    irq = await cg.gpio_pin_expression(config[CONF_IRQ_PIN])
    cg.add(var.set_irq_pin(irq))

    rst = await cg.gpio_pin_expression(config[CONF_RST_PIN])
    cg.add(var.set_rst_pin(rst))

    cg.add(var.set_frequency(config[CONF_FREQUENCY]))
    cg.add(var.set_mode(config[CONF_MODE]))

    if CONF_NODE_ID in config:
        cg.add(var.set_node_id(config[CONF_NODE_ID]))

    if CONF_SYSTEM_KEY in config:
        key_bytes = bytes.fromhex(config[CONF_SYSTEM_KEY])
        cg.add(var.set_system_key(list(key_bytes)))

    if CONF_CHANNELS in config:
        cg.add(var.set_channels(config[CONF_CHANNELS]))

    cg.add(var.set_hop_interval(config[CONF_HOP_INTERVAL]))
    cg.add(var.set_pairing_mode(config[CONF_PAIRING_MODE]))
```

### `components/iohomecontrol/cover.py`

```python
import esphome.codegen as cg
import esphome.config_validation as cv
from esphome.components import cover
from esphome.const import CONF_ID, CONF_NAME
from . import IoHomeControlComponent, iohomecontrol_ns, CONF_NODE_ID, CONF_MODE

DEPENDENCIES = ["iohomecontrol"]

CONF_DEVICE_TYPE = "device_type"

IoHomeControlCover = iohomecontrol_ns.class_(
    "IoHomeControlCover", cover.Cover, cg.Component
)

DEVICE_TYPES = {
    "roller_shutter": 0x00,
    "window_opener": 0x03,
    "venetian_blind": 0x04,
    "exterior_blind": 0x05,
    "garage_door": 0x07,
}

CONFIG_SCHEMA = cover.COVER_SCHEMA.extend(
    {
        cv.GenerateID(): cv.declare_id(IoHomeControlCover),
        cv.Required(CONF_NODE_ID): cv.hex_uint32_t,
        cv.Optional(CONF_DEVICE_TYPE, default="roller_shutter"): cv.enum(
            DEVICE_TYPES, upper=False
        ),
        cv.Optional(CONF_MODE, default="1W"): cv.one_of("1W", "2W", upper=True),
    }
).extend(cv.COMPONENT_SCHEMA)


async def to_code(config):
    var = cg.new_Pvariable(config[CONF_ID])
    await cg.register_component(var, config)
    await cover.register_cover(var, config)

    parent = await cg.get_variable(config[cv.GenerateID(IoHomeControlComponent)])
    cg.add(var.set_parent(parent))

    cg.add(var.set_node_id(config[CONF_NODE_ID]))
    cg.add(var.set_device_type(config[CONF_DEVICE_TYPE]))
    cg.add(var.set_mode(config[CONF_MODE]))
```

## C++ Implementation

### `components/iohomecontrol/iohomecontrol.h`

```cpp
#pragma once

#include "esphome/core/component.h"
#include "esphome/core/hal.h"
#include <RadioLib.h>

namespace esphome {
namespace iohomecontrol {

class IoHomeControlComponent : public Component {
 public:
  void setup() override;
  void loop() override;
  void dump_config() override;
  float get_setup_priority() const override { return setup_priority::HARDWARE; }

  // Configuration
  void set_cs_pin(GPIOPin *pin) { cs_pin_ = pin; }
  void set_irq_pin(GPIOPin *pin) { irq_pin_ = pin; }
  void set_rst_pin(GPIOPin *pin) { rst_pin_ = pin; }
  void set_frequency(float freq) { frequency_ = freq; }
  void set_mode(const std::string &mode) { mode_ = mode; }
  void set_node_id(uint32_t id) { node_id_ = id; }
  void set_system_key(const std::vector<uint8_t> &key) { system_key_ = key; }
  void set_channels(const std::vector<float> &channels) { channels_ = channels; }
  void set_hop_interval(float interval) { hop_interval_ = interval; }
  void set_pairing_mode(bool mode) { pairing_mode_ = mode; }

  // Protocol Functions
  bool send_command(uint32_t node_id, uint8_t cmd_id, const uint8_t *params, size_t len);
  bool set_position(uint32_t node_id, uint8_t position);

 protected:
  GPIOPin *cs_pin_{nullptr};
  GPIOPin *irq_pin_{nullptr};
  GPIOPin *rst_pin_{nullptr};

  float frequency_{868.95};
  std::string mode_{"1W"};
  uint32_t node_id_{0};
  std::vector<uint8_t> system_key_;
  std::vector<float> channels_;
  float hop_interval_{2.7};
  bool pairing_mode_{false};

  // RadioLib instance
  SX1276 *radio_{nullptr};

  // Protocol helpers
  uint16_t calculate_crc16(const uint8_t *data, size_t len);
  void construct_frame(uint32_t dest, uint8_t cmd, const uint8_t *params, size_t len, uint8_t *frame_out);
  void compute_hmac(const uint8_t *frame_data, size_t len, uint8_t *hmac_out);

  uint16_t rolling_code_{0};
};

}  // namespace iohomecontrol
}  // namespace esphome
```

### `components/iohomecontrol/iohomecontrol_cover.h`

```cpp
#pragma once

#include "esphome/components/cover/cover.h"
#include "esphome/core/component.h"
#include "iohomecontrol.h"

namespace esphome {
namespace iohomecontrol {

class IoHomeControlCover : public cover::Cover, public Component {
 public:
  void setup() override;
  void dump_config() override;

  void set_parent(IoHomeControlComponent *parent) { parent_ = parent; }
  void set_node_id(uint32_t id) { node_id_ = id; }
  void set_device_type(uint8_t type) { device_type_ = type; }
  void set_mode(const std::string &mode) { mode_ = mode; }

  cover::CoverTraits get_traits() override;

 protected:
  void control(const cover::CoverCall &call) override;

  IoHomeControlComponent *parent_{nullptr};
  uint32_t node_id_{0};
  uint8_t device_type_{0};
  std::string mode_{"1W"};
};

}  // namespace iohomecontrol
}  // namespace esphome
```

## Implementation-Roadmap

### Phase 1: Basis-Component (1-2 Wochen)
- [x] Python Component Registration
- [ ] C++ Component Grundgerüst
- [ ] RadioLib Integration
- [ ] Basic RF Setup (Frequency, Modulation, Data Rate)
- [ ] CRC-16 Implementation

### Phase 2: Protocol Layer (2-3 Wochen)
- [ ] Frame Construction
- [ ] AES-128 Integration (mbedTLS aus ESP-IDF)
- [ ] IV Construction
- [ ] HMAC Generation
- [ ] 1W Mode Implementation

### Phase 3: Cover Platform (1 Woche)
- [ ] Cover Traits definieren (Position, Tilt wenn unterstützt)
- [ ] Open/Close/Stop Commands
- [ ] Position Control (0-100%)
- [ ] State Feedback (wenn 2W)

### Phase 4: Testing & Debugging (fortlaufend)
- [ ] Unit Tests
- [ ] Integration Tests mit echter Hardware
- [ ] Home Assistant Integration testen
- [ ] Documentation

### Phase 5: Advanced Features (2-4 Wochen)
- [ ] 2W Mode mit Frequency Hopping
- [ ] Pairing Mode über ESPHome Service
- [ ] Multiple Devices Support
- [ ] RSSI/SNR Sensors
- [ ] OTA-Updates mit Verschlüsselung

## Technische Details

### Cover-Befehle (1W Mode)

```cpp
// Position setzen (0-100%)
void IoHomeControlCover::control(const cover::CoverCall &call) {
  if (call.get_position().has_value()) {
    float pos = *call.get_position();
    uint8_t position = (uint8_t)(pos * 100.0f);

    // Command 0x?? für Position (muss aus Docs ermittelt werden)
    uint8_t params[2] = {position, 0x00};
    this->parent_->send_command(this->node_id_, CMD_SET_POSITION, params, 2);

    this->position = pos;
    this->publish_state();
  }

  if (call.get_stop()) {
    uint8_t params[1] = {0x00};
    this->parent_->send_command(this->node_id_, CMD_STOP, params, 1);
  }
}
```

### ESPHome Services für Pairing

```yaml
# In der YAML-Config:
esphome:
  on_boot:
    - lambda: |-
        // Custom Service für Pairing registrieren
        register_service(&IoHomeControlCover::start_pairing,
                        "start_pairing",
                        {"node_id"});
```

### Home Assistant Automation-Beispiel

```yaml
# configuration.yaml
automation:
  - alias: "Rollo bei Sonnenaufgang öffnen"
    trigger:
      - platform: sun
        event: sunrise
    action:
      - service: cover.open_cover
        target:
          entity_id: cover.velux_rollo
```

## Vorteile gegenüber Standalone-Implementation

1. **Kein MQTT-Broker nötig**: ESPHome API kommuniziert direkt mit HA
2. **Auto-Discovery**: Geräte erscheinen automatisch in HA
3. **Native Cover-Entity**: Alle HA-Features (Automationen, UI, Dashboards)
4. **OTA-Updates**: Firmware-Updates über HA Web-UI
5. **Logging**: Echtzeit-Logs im ESPHome Dashboard
6. **Konfiguration**: YAML statt C++ für Nutzer-Einstellungen

## Kompatibilität

- **ESPHome Version**: >= 2023.12.0 (für moderne Component-API)
- **Home Assistant**: >= 2023.12.0
- **ESP32**: Alle Varianten (ESP32, ESP32-S2, ESP32-S3, ESP32-C3)
- **Radio-Module**: SX1276, RFM69, RFM95, Si4463 (via RadioLib)

## Migration von Arduino zu ESPHome

Die existierende `src/IoHome.cpp` kann größtenteils übernommen werden:

1. **RadioLib** wird in ESPHome genauso verwendet
2. **mbedTLS** ist in ESP-IDF enthalten
3. **Crypto-Funktionen** aus `scripts/Iown-ioCrypto.py` nach C++ portieren
4. **Frame-Parsing** aus `scripts/Iown-IoHexFrameParser.py` integrieren

## Nächste Schritte

1. **Prototyp erstellen**: Minimale Component mit RadioLib-Setup
2. **CRC-16 testen**: Mit bekannten Test-Vektoren
3. **Frame senden**: Einfacher Command ohne Encryption
4. **AES integrieren**: Mit Transfer-Key testen
5. **Cover-Platform**: Open/Close implementieren
6. **Testing**: Mit echtem Velux-Gerät
