/**
 * @file iohomecontrol_component.cpp
 * @brief ESPHome Component for io-homecontrol Implementation
 * @author iown-homecontrol project
 */

#include "iohomecontrol_component.h"
#include "esphome/core/log.h"
#include <SPI.h>

namespace esphome {
namespace iohomecontrol {

void IoHomeControlComponent::set_node_id(const std::vector<uint8_t> &id) {
  if (id.size() == 3) {
    memcpy(node_id_, id.data(), 3);
  } else {
    ESP_LOGE(TAG, "Invalid node ID size: %d (expected 3)", id.size());
  }
}

void IoHomeControlComponent::set_system_key(const std::vector<uint8_t> &key) {
  if (key.size() == 16) {
    memcpy(system_key_, key.data(), 16);
  } else {
    ESP_LOGE(TAG, "Invalid system key size: %d (expected 16)", key.size());
  }
}

void IoHomeControlComponent::setup() {
  ESP_LOGCONFIG(TAG, "Setting up io-homecontrol component...");

  // Configure SPI pins
  SPIClass *spi = &SPI;
  spi->begin();

  // Create RadioLib module instance
  // Note: Adjust pins for your specific board (example for Heltec WiFi LoRa 32 V2)
  uint8_t cs_pin = cs_pin_->get_pin();
  uint8_t irq_pin = irq_pin_->get_pin();
  uint8_t rst_pin = rst_pin_->get_pin();
  uint8_t dio1_pin = 33;  // Board-specific, adjust as needed

  radio_module_ = new Module(cs_pin, irq_pin, rst_pin, dio1_pin, *spi);

  // Create radio instance (SX1276 for most LoRa32 boards)
  radio_ = new SX1276(radio_module_);

  // Initialize radio
  int state = radio_->begin();
  if (state != RADIOLIB_ERR_NONE) {
    ESP_LOGE(TAG, "Radio initialization failed: %d", state);
    this->mark_failed();
    return;
  }

  ESP_LOGI(TAG, "Radio initialized successfully");

  // Create protocol controller
  controller_ = new iohome::IoHomeControl(radio_);

  // Initialize controller
  if (!controller_->begin(node_id_, system_key_, is_1w_mode_)) {
    ESP_LOGE(TAG, "Controller initialization failed");
    this->mark_failed();
    return;
  }

  // Configure radio
  state = controller_->configure_radio(frequency_);
  if (state != RADIOLIB_ERR_NONE) {
    ESP_LOGE(TAG, "Radio configuration failed: %d", state);
    this->mark_failed();
    return;
  }

  // Enable verbose logging
  controller_->set_verbose(verbose_);

  // Start receiving
  state = controller_->start_receive();
  if (state != RADIOLIB_ERR_NONE) {
    ESP_LOGE(TAG, "Failed to start receiving: %d", state);
    this->mark_failed();
    return;
  }

  ESP_LOGCONFIG(TAG, "io-homecontrol component ready");
}

void IoHomeControlComponent::loop() {
  if (controller_ == nullptr) {
    return;
  }

  // Check for received frames
  iohome::frame::IoFrame frame;
  int16_t rssi;
  float snr;

  if (controller_->check_received(&frame, &rssi, &snr)) {
    ESP_LOGD(TAG, "Frame received from %02X%02X%02X (RSSI: %d dBm, SNR: %.1f dB)",
             frame.src_node[0], frame.src_node[1], frame.src_node[2],
             rssi, snr);

    // Frame processing is handled by child components (covers)
    // Child components register callbacks with the controller if needed
  }
}

void IoHomeControlComponent::dump_config() {
  ESP_LOGCONFIG(TAG, "io-homecontrol:");
  ESP_LOGCONFIG(TAG, "  Node ID: %02X %02X %02X",
                node_id_[0], node_id_[1], node_id_[2]);
  ESP_LOGCONFIG(TAG, "  Frequency: %.2f MHz", frequency_);
  ESP_LOGCONFIG(TAG, "  Mode: %s", is_1w_mode_ ? "1W" : "2W");
  ESP_LOGCONFIG(TAG, "  CS Pin: GPIO%d", cs_pin_->get_pin());
  ESP_LOGCONFIG(TAG, "  IRQ Pin: GPIO%d", irq_pin_->get_pin());
  ESP_LOGCONFIG(TAG, "  RST Pin: GPIO%d", rst_pin_->get_pin());
  ESP_LOGCONFIG(TAG, "  Verbose: %s", verbose_ ? "YES" : "NO");

  if (controller_ != nullptr) {
    ESP_LOGCONFIG(TAG, "  Status: OK");
  } else {
    ESP_LOGCONFIG(TAG, "  Status: FAILED");
  }
}

}  // namespace iohomecontrol
}  // namespace esphome
