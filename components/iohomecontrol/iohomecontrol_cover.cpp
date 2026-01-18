/**
 * @file iohomecontrol_cover.cpp
 * @brief ESPHome Cover Platform for io-homecontrol Implementation
 * @author iown-homecontrol project
 */

#include "iohomecontrol_cover.h"
#include "esphome/core/log.h"

namespace esphome {
namespace iohomecontrol {

static const char *const TAG = "iohomecontrol.cover";

void IoHomeControlCover::set_node_id(const std::vector<uint8_t> &id) {
  if (id.size() == 3) {
    memcpy(node_id_, id.data(), 3);
  } else {
    ESP_LOGE(TAG, "Invalid node ID size: %d (expected 3)", id.size());
  }
}

void IoHomeControlCover::setup() {
  ESP_LOGCONFIG(TAG, "Setting up io-homecontrol cover...");

  // Initialize position to unknown
  this->position = COVER_OPEN;
  this->publish_state();
}

void IoHomeControlCover::dump_config() {
  ESP_LOGCONFIG(TAG, "io-homecontrol Cover:");
  ESP_LOGCONFIG(TAG, "  Node ID: %02X %02X %02X",
                node_id_[0], node_id_[1], node_id_[2]);
  ESP_LOGCONFIG(TAG, "  Device Type: 0x%02X", device_type_);
}

cover::CoverTraits IoHomeControlCover::get_traits() {
  auto traits = cover::CoverTraits();
  traits.set_supports_position(true);
  traits.set_supports_tilt(false);
  traits.set_is_assumed_state(true);  // No feedback from 1W devices
  return traits;
}

void IoHomeControlCover::control(const cover::CoverCall &call) {
  if (parent_ == nullptr || parent_->get_controller() == nullptr) {
    ESP_LOGE(TAG, "Parent controller not available");
    return;
  }

  iohome::IoHomeControl *controller = parent_->get_controller();

  // Handle STOP command
  if (call.get_stop()) {
    ESP_LOGI(TAG, "Stopping cover");
    if (controller->stop(node_id_)) {
      ESP_LOGD(TAG, "Stop command sent successfully");
    } else {
      ESP_LOGE(TAG, "Failed to send stop command");
    }
    return;
  }

  // Handle POSITION command
  if (call.get_position().has_value()) {
    float pos = *call.get_position();
    uint8_t position = (uint8_t)(pos * 100.0f);

    ESP_LOGI(TAG, "Setting position to %d%%", position);

    if (controller->set_position(node_id_, position)) {
      ESP_LOGD(TAG, "Position command sent successfully");

      // Update state (assumed, since 1W has no feedback)
      this->position = pos;
      this->publish_state();
    } else {
      ESP_LOGE(TAG, "Failed to send position command");
    }
    return;
  }

  // Handle OPEN command
  if (call.get_position() == COVER_OPEN) {
    ESP_LOGI(TAG, "Opening cover");
    if (controller->open(node_id_)) {
      ESP_LOGD(TAG, "Open command sent successfully");
      this->position = COVER_OPEN;
      this->publish_state();
    } else {
      ESP_LOGE(TAG, "Failed to send open command");
    }
    return;
  }

  // Handle CLOSE command
  if (call.get_position() == COVER_CLOSED) {
    ESP_LOGI(TAG, "Closing cover");
    if (controller->close(node_id_)) {
      ESP_LOGD(TAG, "Close command sent successfully");
      this->position = COVER_CLOSED;
      this->publish_state();
    } else {
      ESP_LOGE(TAG, "Failed to send close command");
    }
    return;
  }
}

}  // namespace iohomecontrol
}  // namespace esphome
