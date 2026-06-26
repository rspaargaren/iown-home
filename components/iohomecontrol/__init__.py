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
IoHomeControlComponent = iohomecontrol_ns.class_("IoHomeControlComponent", cg.Component)

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
