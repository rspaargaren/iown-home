/**
 * @file iohomecontrol_component.h
 * @brief ESPHome Component for io-homecontrol
 * @author iown-homecontrol project
 */

#pragma once

#include "esphome/core/component.h"
#include "esphome/core/hal.h"
#include "esphome/core/log.h"
#include <RadioLib.h>

// Include protocol library (relative to src/)
#include "../../src/IoHomeControl.h"

namespace esphome {
namespace iohomecontrol {

static const char *const TAG = "iohomecontrol";

/**
 * @brief ESPHome Component for io-homecontrol
 *
 * This component provides the main interface for io-homecontrol communication
 * within ESPHome. It manages the radio hardware and protocol handling.
 */
class IoHomeControlComponent : public Component {
 public:
  IoHomeControlComponent() : controller_(nullptr) {}

  void setup() override;
  void loop() override;
  void dump_config() override;
  float get_setup_priority() const override { return setup_priority::HARDWARE; }

  // Configuration setters (called from Python code generation)
  void set_cs_pin(GPIOPin *pin) { cs_pin_ = pin; }
  void set_irq_pin(GPIOPin *pin) { irq_pin_ = pin; }
  void set_rst_pin(GPIOPin *pin) { rst_pin_ = pin; }
  void set_node_id(const std::vector<uint8_t> &id);
  void set_system_key(const std::vector<uint8_t> &key);
  void set_frequency(float freq) { frequency_ = freq; }
  void set_mode(bool is_1w) { is_1w_mode_ = is_1w; }
  void set_verbose(bool verbose) { verbose_ = verbose; }

  // Get the controller instance (for use by cover platform)
  iohome::IoHomeControl *get_controller() { return controller_; }

 protected:
  GPIOPin *cs_pin_{nullptr};
  GPIOPin *irq_pin_{nullptr};
  GPIOPin *rst_pin_{nullptr};

  uint8_t node_id_[3];
  uint8_t system_key_[16];
  float frequency_{868.95f};
  bool is_1w_mode_{true};
  bool verbose_{false};

  // RadioLib radio instance
  Module *radio_module_{nullptr};
  SX1276 *radio_{nullptr};

  // Protocol controller
  iohome::IoHomeControl *controller_{nullptr};
};

}  // namespace iohomecontrol
}  // namespace esphome
