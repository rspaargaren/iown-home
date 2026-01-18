/**
 * @file iohomecontrol_cover.h
 * @brief ESPHome Cover Platform for io-homecontrol
 * @author iown-homecontrol project
 */

#pragma once

#include "esphome/components/cover/cover.h"
#include "esphome/core/component.h"
#include "iohomecontrol_component.h"

namespace esphome {
namespace iohomecontrol {

/**
 * @brief ESPHome Cover for io-homecontrol devices
 *
 * This class implements the ESPHome Cover interface for io-homecontrol
 * actuators like blinds, shutters, and window openers.
 */
class IoHomeControlCover : public cover::Cover, public Component {
 public:
  void setup() override;
  void dump_config() override;

  cover::CoverTraits get_traits() override;

  void set_parent(IoHomeControlComponent *parent) { parent_ = parent; }
  void set_node_id(const std::vector<uint8_t> &id);
  void set_device_type(uint8_t type) { device_type_ = type; }

 protected:
  void control(const cover::CoverCall &call) override;

  IoHomeControlComponent *parent_{nullptr};
  uint8_t node_id_[3];
  uint8_t device_type_{0x00};  // Default: roller shutter
};

}  // namespace iohomecontrol
}  // namespace esphome
