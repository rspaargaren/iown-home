"""ESPHome cover platform for io-homecontrol devices."""
import esphome.codegen as cg
import esphome.config_validation as cv
from esphome.components import cover
from esphome.const import CONF_ID
from . import (
    iohomecontrol_ns,
    IoHomeControl,
    CONF_NODE_ID,
    validate_node_id,
)

DEPENDENCIES = ["iohomecontrol"]

CONF_IOHOMECONTROL_ID = "iohomecontrol_id"
CONF_DEVICE_TYPE = "device_type"

# Device types
DEVICE_TYPES = {
    "roller_shutter": 0x00,
    "adjustable_slat_shutter": 0x01,
    "screen": 0x02,
    "window_opener": 0x03,
    "venetian_blind": 0x04,
    "exterior_blind": 0x05,
    "dual_shutter": 0x06,
    "garage_door": 0x07,
    "awning": 0x08,
    "curtain": 0x09,
    "pergola": 0x0A,
    "horizontal_awning": 0x0B,
    "exterior_screen": 0x0C,
}

IoHomeControlCover = iohomecontrol_ns.class_(
    "IoHomeControlCover", cover.Cover, cg.Component
)

CONFIG_SCHEMA = cover.COVER_SCHEMA.extend(
    {
        cv.GenerateID(): cv.declare_id(IoHomeControlCover),
        cv.GenerateID(CONF_IOHOMECONTROL_ID): cv.use_id(IoHomeControl),
        cv.Required(CONF_NODE_ID): validate_node_id,
        cv.Optional(CONF_DEVICE_TYPE, default="roller_shutter"): cv.enum(
            DEVICE_TYPES, lower=True
        ),
    }
).extend(cv.COMPONENT_SCHEMA)


async def to_code(config):
    """Generate C++ code for the cover platform."""
    var = cg.new_Pvariable(config[CONF_ID])
    await cg.register_component(var, config)
    await cover.register_cover(var, config)

    # Get parent component
    parent = await cg.get_variable(config[CONF_IOHOMECONTROL_ID])
    cg.add(var.set_parent(parent))

    # Convert node ID to bytes (3 bytes, big-endian)
    node_id = config[CONF_NODE_ID]
    node_id_bytes = [
        (node_id >> 16) & 0xFF,
        (node_id >> 8) & 0xFF,
        node_id & 0xFF,
    ]
    cg.add(var.set_node_id(node_id_bytes))

    # Set device type
    cg.add(var.set_device_type(config[CONF_DEVICE_TYPE]))
