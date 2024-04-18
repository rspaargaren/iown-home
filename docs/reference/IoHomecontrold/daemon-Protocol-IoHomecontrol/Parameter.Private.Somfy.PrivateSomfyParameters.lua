﻿local var_0_0 = require("Overkiz.HomeAutomation.Shared.IoHomecontrolOvp.Node.nodeModel")
local var_0_1 = require("Overkiz.HomeAutomation.Protocol.IoHomecontrol.Parameter.factory")
local var_0_2 = require("Overkiz.HomeAutomation.Protocol.IoHomecontrol.Parameter.Private.Factory.manufacturerParametersFactory")
local var_0_3 = require("Overkiz.HomeAutomation.Protocol.IoHomecontrol.log")
local var_0_4 = require("Overkiz.HomeAutomation.Protocol.IoHomecontrol.Parameter.Private.Somfy.constants")
local var_0_5 = require("Overkiz.utilities")
local var_0_6 = require("pl.List")
local var_0_7 = {}
local var_0_8 = {
	Saturday = 6,
	Wednesday = 3,
	Thursday = 4,
	Sunday = 7,
	Monday = 1,
	Tuesday = 2,
	Friday = 5
}
local var_0_9 = {
	randomRange = 360,
	hour = 0,
	weekday = var_0_8.everyday
}
local var_0_10 = {
	weekday = var_0_8.Monday,
	hour = var_0_9.hour,
	randomRange = var_0_9.randomRange
}
local var_0_11 = {
	monthday = 15,
	hour = var_0_9.hour,
	randomRange = var_0_9.randomRange
}
local var_0_12 = {
	randomRange = 20
}
local var_0_13 = {
	randomRange = 0
}
local var_0_14 = {
	SERVEGO = "serv-e-go"
}

var_0_7.objects = {
	[var_0_4.object0000] = {
		parameter = 5,
		name = "List of objects arrays managed",
		data = {
			2,
			0,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.object1000] = {
		parameter = 5,
		name = "Hardware platform",
		data = {
			2,
			16,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.object6100] = {
		parameter = 5,
		name = "Product Identification",
		data = {
			2,
			97,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.object6101] = {
		parameter = 5,
		name = "General information",
		data = {
			2,
			97,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.object6102] = {
		parameter = 5,
		name = "Memory dump",
		data = {
			2,
			97,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.object6103] = {
		parameter = 5,
		name = "Two way configuration data",
		data = {
			2,
			97,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.object6104] = {
		parameter = 5,
		name = "Settings",
		data = {
			2,
			97,
			4
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.object6105] = {
		parameter = 5,
		name = "Advanced feedback",
		data = {
			2,
			97,
			5
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.object8001] = {
		parameter = 5,
		name = "Software version",
		data = {
			0,
			128,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.object8002] = {
		parameter = 5,
		name = "General Info 2",
		data = {
			0,
			128,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.object8003] = {
		parameter = 5,
		name = "Name",
		data = {
			0,
			128,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.object8101] = {
		parameter = 5,
		name = "Gate type",
		data = {
			0,
			129,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA100] = {
		parameter = 8,
		name = "Operating mode",
		data = {
			2,
			161,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA101] = {
		parameter = 8,
		name = "Total control timed closing",
		data = {
			2,
			161,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA102] = {
		parameter = 8,
		name = "Pedestrian control operating mode",
		data = {
			2,
			161,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA103] = {
		parameter = 8,
		name = "Pedestrian control short timed mode",
		data = {
			2,
			161,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA104] = {
		parameter = 8,
		name = "Pedestrian control long timed mode",
		data = {
			2,
			161,
			4
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA105] = {
		parameter = 8,
		name = "Orange light warning",
		data = {
			2,
			161,
			5
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA106] = {
		parameter = 8,
		name = "Closing speed",
		data = {
			2,
			161,
			6
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA107] = {
		parameter = 8,
		name = "Opening speed",
		data = {
			2,
			161,
			7
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA108] = {
		parameter = 8,
		name = "Closing slowdown zone",
		data = {
			2,
			161,
			8
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA109] = {
		parameter = 8,
		name = "Opening slowdown zone",
		data = {
			2,
			161,
			9
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10A] = {
		parameter = 8,
		name = "Motor1/Motor2 offset when closing",
		data = {
			2,
			161,
			10
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10B] = {
		parameter = 8,
		name = "Motor1/Motor2 offset when opening",
		data = {
			2,
			161,
			11
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10C] = {
		parameter = 8,
		name = "Motor1 closing torque",
		data = {
			2,
			161,
			12
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10D] = {
		parameter = 8,
		name = "Motor1 opening torque",
		data = {
			2,
			161,
			13
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10E] = {
		parameter = 8,
		name = "Motor1 closing slowdown torque",
		data = {
			2,
			161,
			14
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA10F] = {
		parameter = 8,
		name = "Motor1 opening slowdown torque limitation",
		data = {
			2,
			161,
			15
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA110] = {
		parameter = 8,
		name = "Motor2 closing torque",
		data = {
			2,
			161,
			16
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA111] = {
		parameter = 8,
		name = "Motor2 opening torque",
		data = {
			2,
			161,
			17
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA112] = {
		parameter = 8,
		name = "Motor2 closing slowdown torque",
		data = {
			2,
			161,
			18
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA113] = {
		parameter = 8,
		name = "Motor2 opening slowdown torque",
		data = {
			2,
			161,
			19
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA114] = {
		parameter = 8,
		name = "Id of motor direction",
		data = {
			2,
			161,
			20
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA116] = {
		parameter = 8,
		name = "Obstacle detection sensivity",
		data = {
			2,
			161,
			22
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA117] = {
		parameter = 8,
		name = "Photocells activation",
		data = {
			2,
			161,
			23
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA118] = {
		parameter = 8,
		name = "Safety edge activation",
		data = {
			2,
			161,
			24
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA119] = {
		parameter = 8,
		name = "Programmable activation",
		data = {
			2,
			161,
			25
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11A] = {
		parameter = 8,
		name = "Programmable safety input - Functionning",
		data = {
			2,
			161,
			26
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11B] = {
		parameter = 8,
		name = "Programmable safety input - Action",
		data = {
			2,
			161,
			27
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11C] = {
		parameter = 8,
		name = "Wired control inputs mode",
		data = {
			2,
			161,
			28
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11D] = {
		parameter = 8,
		name = "Lighting area output",
		data = {
			2,
			161,
			29
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11E] = {
		parameter = 8,
		name = "Lighting area time delay",
		data = {
			2,
			161,
			30
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA11F] = {
		parameter = 8,
		name = "Auxiliary output",
		data = {
			2,
			161,
			31
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA120] = {
		parameter = 8,
		name = "Auxiliary output time delay",
		data = {
			2,
			161,
			32
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA121] = {
		parameter = 8,
		name = "Electric lock output",
		data = {
			2,
			161,
			33
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA122] = {
		parameter = 8,
		name = "Gate type",
		data = {
			2,
			161,
			34
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA124] = {
		parameter = 8,
		name = "Additional thrust when closing",
		data = {
			2,
			161,
			36
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA126] = {
		parameter = 8,
		name = "Pedestrian opening position",
		data = {
			2,
			161,
			38
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA129] = {
		parameter = 8,
		name = "Product programming interface",
		data = {
			2,
			161,
			41
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA12B] = {
		parameter = 8,
		name = "Closing slowdown speed",
		data = {
			2,
			161,
			43
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA12C] = {
		parameter = 8,
		name = "Opening slowdown speed",
		data = {
			2,
			161,
			44
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA132] = {
		parameter = 8,
		name = "Id of action control",
		data = {
			2,
			161,
			50
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA133] = {
		parameter = 8,
		name = "Id of Intermediary position",
		data = {
			2,
			161,
			51
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA134] = {
		parameter = 8,
		name = "Timed closing",
		data = {
			2,
			161,
			52
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA137] = {
		parameter = 8,
		name = "Id of Pop position",
		data = {
			2,
			161,
			55
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA138] = {
		parameter = 8,
		name = "Id of Access Actuator location of current position",
		data = {
			2,
			161,
			56
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA12A] = {
		parameter = 8,
		name = "Anti-trapping activaction",
		data = {
			2,
			161,
			42
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA203] = {
		parameter = 8,
		name = "Safety Edge - Type",
		data = {
			2,
			162,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA205] = {
		parameter = 8,
		name = "Motor travel length mm",
		data = {
			2,
			162,
			5
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA223] = {
		parameter = 8,
		name = "Aditional thrust when closing",
		data = {
			2,
			162,
			35
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA224] = {
		parameter = 8,
		name = "Photocells latest autotest status",
		data = {
			2,
			162,
			36
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA226] = {
		parameter = 8,
		name = "Product setting status",
		data = {
			2,
			162,
			38
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA227] = {
		parameter = 8,
		name = "Active power supply",
		data = {
			2,
			162,
			39
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA228] = {
		parameter = 8,
		name = "Wired total control input status",
		data = {
			2,
			162,
			40
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA229] = {
		parameter = 8,
		name = "Wired pedestrian control input status",
		data = {
			2,
			162,
			41
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA22A] = {
		parameter = 8,
		name = "Photocells input status",
		data = {
			2,
			162,
			42
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA22B] = {
		parameter = 8,
		name = "Safety edge input status",
		data = {
			2,
			162,
			43
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA22C] = {
		parameter = 8,
		name = "Wicket door safety input status",
		data = {
			2,
			162,
			44
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA232] = {
		parameter = 8,
		name = "Garage door type",
		data = {
			2,
			162,
			50
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA233] = {
		parameter = 8,
		name = "Photocells latest autotest status",
		data = {
			2,
			162,
			51
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA234] = {
		parameter = 8,
		name = "Latest programmable autotest status",
		data = {
			2,
			162,
			52
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA235] = {
		parameter = 8,
		name = "Software version",
		data = {
			2,
			162,
			53
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA236] = {
		parameter = 8,
		name = "Technical reference",
		data = {
			2,
			162,
			54
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA237] = {
		parameter = 8,
		name = "Number of RTX 1W remote",
		data = {
			2,
			162,
			55
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA238] = {
		parameter = 8,
		name = "Id of industrialisation of manufacturing date",
		data = {
			2,
			162,
			56
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA239] = {
		parameter = 8,
		name = "Commercial name",
		data = {
			2,
			162,
			57
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA23A] = {
		parameter = 8,
		name = "Technical product",
		data = {
			2,
			162,
			58
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA23C] = {
		parameter = 8,
		name = "Daughter board sofware version",
		data = {
			2,
			162,
			60
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA23D] = {
		parameter = 8,
		name = "Daughter board hardware version",
		data = {
			2,
			162,
			61
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA23E] = {
		parameter = 8,
		name = "Hardware version",
		data = {
			2,
			162,
			62
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA246] = {
		parameter = 8,
		name = "Safety edge latest autotest status",
		data = {
			2,
			162,
			70
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA247] = {
		parameter = 8,
		name = "Wicket door safety input latest autotest status",
		data = {
			2,
			162,
			71
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA249] = {
		parameter = 8,
		name = "24v power supply for accessories",
		data = {
			2,
			162,
			73
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA24A] = {
		parameter = 8,
		name = "Last results on fall autotests",
		data = {
			2,
			162,
			74
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA318] = {
		parameter = 8,
		name = "Number of local orders",
		data = {
			2,
			163,
			24
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA319] = {
		parameter = 8,
		name = "Number of remote orders",
		data = {
			2,
			163,
			25
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA328] = {
		parameter = 8,
		name = "fall prevention input state",
		data = {
			2,
			163,
			40
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA332] = {
		parameter = 8,
		name = "Public event list",
		data = {
			2,
			163,
			50
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.objectA400] = {
		parameter = 8,
		name = "Total number of cycles",
		data = {
			2,
			164,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA401] = {
		parameter = 8,
		name = "Number of cycles for pedestrian control",
		data = {
			2,
			164,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA402] = {
		parameter = 8,
		name = "Number of cycles since latest self learning",
		data = {
			2,
			164,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA403] = {
		parameter = 8,
		name = "Number of global rescaling",
		data = {
			2,
			164,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA404] = {
		parameter = 8,
		name = "Number of global obstacle detections",
		data = {
			2,
			164,
			4
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA405] = {
		parameter = 8,
		name = "Number of obstacle detections in opening",
		data = {
			2,
			164,
			5
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA406] = {
		parameter = 8,
		name = "Number of obstacle detections in closing",
		data = {
			2,
			164,
			6
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA407] = {
		parameter = 8,
		name = "Number of obstacle dectections since latest self learning",
		data = {
			2,
			164,
			7
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA409] = {
		parameter = 8,
		name = "List of last 10 defaults",
		data = {
			2,
			164,
			9
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA40E] = {
		parameter = 8,
		name = "Id of RTX info request",
		data = {
			2,
			164,
			14
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA40F] = {
		parameter = 8,
		name = "Number of 1w remote controls paired to lighting",
		data = {
			2,
			164,
			15
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA410] = {
		parameter = 8,
		name = "Number of 1w remote controls paired to auxiliary",
		data = {
			2,
			164,
			16
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA411] = {
		parameter = 8,
		name = "Number of 1w remote controls paired to auxiliary output",
		data = {
			2,
			164,
			17
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA416] = {
		parameter = 8,
		name = "Number of remote orders for motor 3S",
		data = {
			2,
			164,
			22
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA417] = {
		parameter = 8,
		name = "Number of remote orders for light and auxiliary 3S",
		data = {
			2,
			164,
			23
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA418] = {
		parameter = 8,
		name = "Number of obstacle detections",
		data = {
			2,
			164,
			24
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA419] = {
		parameter = 8,
		name = "Number of obstacle dectections since latest learning",
		data = {
			2,
			164,
			25
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA41C] = {
		parameter = 8,
		name = "Total number of cycles",
		data = {
			2,
			164,
			28
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA41D] = {
		parameter = 8,
		name = "Number of cycles for pedestrian control",
		data = {
			2,
			164,
			29
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA41E] = {
		parameter = 8,
		name = "Number of cycles  since latest self learning",
		data = {
			2,
			164,
			30
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA41F] = {
		parameter = 8,
		name = "Number of global rescaling for 3S",
		data = {
			2,
			164,
			31
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA44D] = {
		parameter = 8,
		name = "Number of 1w remote controls paired to motor for total control",
		data = {
			2,
			164,
			77
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA44E] = {
		parameter = 8,
		name = "Number of 1w remote controls paired to motor for pedestrian control",
		data = {
			2,
			164,
			78
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA450] = {
		parameter = 8,
		name = "Id system key 2 stored",
		data = {
			2,
			164,
			80
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.objectA451] = {
		parameter = 8,
		name = "Name",
		data = {
			2,
			164,
			81
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA503] = {
		parameter = 8,
		name = "Reset historical counters",
		data = {
			2,
			165,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.objectA504] = {
		parameter = 8,
		name = "Go into Factory mode",
		data = {
			2,
			165,
			4
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.objectA600] = {
		parameter = 8,
		name = "1W transmitter address",
		data = {
			2,
			166,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	},
	[var_0_4.objectA601] = {
		parameter = 5,
		name = "Power Line measurement",
		data = {
			2,
			166,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA602] = {
		parameter = 5,
		name = "Statistics data",
		data = {
			2,
			166,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA603] = {
		parameter = 5,
		name = "Product setting data",
		data = {
			2,
			166,
			3
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA604] = {
		parameter = 5,
		name = "Profile io",
		data = {
			2,
			166,
			4
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA606] = {
		parameter = 5,
		name = "Operating temperature data",
		data = {
			2,
			166,
			6
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA607] = {
		parameter = 5,
		name = "One way pairing data",
		data = {
			2,
			166,
			7
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA608] = {
		parameter = 5,
		name = "",
		data = {
			2,
			166,
			8
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA609] = {
		parameter = 5,
		name = "Travel control Positions",
		data = {
			2,
			166,
			9
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60A] = {
		parameter = 5,
		name = "End limit detection",
		data = {
			2,
			166,
			10
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60B] = {
		parameter = 5,
		name = "Position Adjustement",
		data = {
			2,
			166,
			11
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60C] = {
		parameter = 5,
		name = "10 lines of 16 char",
		data = {
			2,
			166,
			12,
			0,
			0,
			0,
			163
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60C_SENSOR] = {
		parameter = 5,
		name = "10 lines of 16 char",
		data = {
			2,
			166,
			12,
			0,
			0,
			0,
			163
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_13,
			onRecurrence = var_0_11
		}
	},
	[var_0_4.objectA60D] = {
		parameter = 5,
		name = "number of paired masters 1W",
		data = {
			2,
			166,
			13
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60E] = {
		parameter = 5,
		name = "Sensors settings",
		data = {
			2,
			166,
			14
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA60F] = {
		parameter = 5,
		name = "Reset statistic informations",
		data = {
			2,
			166,
			15
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA610] = {
		parameter = 5,
		name = "OEM initial settings",
		data = {
			2,
			166,
			16
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA612] = {
		parameter = 5,
		name = "Actuator P&P current mode",
		data = {
			2,
			166,
			18
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_10
		}
	},
	[var_0_4.objectA613] = {
		parameter = 5,
		name = "Last Events",
		data = {
			2,
			166,
			19
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12,
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA614] = {
		parameter = 5,
		name = "Production Info",
		data = {
			2,
			166,
			20
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_13
		}
	},
	[var_0_4.objectA615] = {
		parameter = 5,
		name = "OEM tracability",
		data = {
			2,
			166,
			21
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_13
		}
	},
	[var_0_4.objectA617] = {
		parameter = 5,
		name = "Speed management",
		data = {
			2,
			166,
			23
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA618] = {
		parameter = 5,
		name = "Back to Factory Mode Informations",
		data = {
			2,
			166,
			24
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectA619] = {
		parameter = 5,
		name = "Torque Curves",
		data = {
			2,
			166,
			25
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA61A] = {
		parameter = 5,
		name = "Product life history",
		data = {
			2,
			166,
			26
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA61B] = {
		parameter = 5,
		name = "Number of hard/soft obstacles motorisations",
		data = {
			2,
			166,
			27
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectA61C] = {
		parameter = 5,
		name = "Sliding window motorisation",
		data = {
			2,
			166,
			28
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectB000] = {
		parameter = 5,
		name = "Window static description",
		data = {
			2,
			176,
			0
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_13,
			onRecurrence = var_0_11
		}
	},
	[var_0_4.objectB001] = {
		parameter = 5,
		name = "Window dynamic description",
		data = {
			2,
			176,
			1
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onRecurrence = var_0_9
		}
	},
	[var_0_4.objectB002] = {
		parameter = 5,
		name = "Horizontal rotation direction",
		data = {
			2,
			176,
			2
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_13
		}
	},
	[var_0_4.objectFFFD] = {
		parameter = 5,
		name = "DEBUG",
		data = {
			2,
			255,
			253
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			},
			onDelayedStart = var_0_12
		}
	},
	[var_0_4.objectFFFF] = {
		parameter = 5,
		name = "Data from PDG structure",
		data = {
			2,
			255,
			255
		},
		refresh = {
			technical = {
				var_0_14.SERVEGO
			}
		}
	}
}

local function var_0_15(arg_1_0, arg_1_1)
	if #arg_1_1 == #arg_1_0 then
		for iter_1_0 = 1, #arg_1_1 do
			if arg_1_1[iter_1_0] < arg_1_0:byte(iter_1_0) then
				return true
			elseif arg_1_1[iter_1_0] > arg_1_0:byte(iter_1_0) then
				return false
			end
		end
	end

	return false
end

function var_0_7.createFactoryParameters(arg_2_0)
	local var_2_0 = tostring(var_0_0.getProfile(arg_2_0))
	local var_2_1 = var_0_6(var_0_5.tableExtract(arg_2_0.generalinfo[1], 1, 7)):map(string.char):join()
	local var_2_2 = var_0_5.tableExtract(arg_2_0.generalinfo[1], 8, 3)
	local var_2_3 = "Overkiz.HomeAutomation.Protocol.IoHomecontrol.Parameter.Private.Somfy."

	local function var_2_4(arg_3_0)
		if arg_3_0 == var_0_0.class.ACTUATOR then
			return var_2_3 .. "C0."
		elseif arg_3_0 == var_0_0.class.SENSOR then
			return var_2_3 .. "C1."
		else
			error("node class " .. tostring(arg_3_0) .. "isn't handled")
		end
	end

	local var_2_5, var_2_6 = pcall(require, var_2_4(arg_2_0.class) .. var_2_0)

	if var_2_5 then
		local var_2_7 = var_2_6[var_2_1]

		if var_2_7 then
			if var_2_7.index then
				if not var_2_2 or not next(var_2_2) then
					var_0_3:error("Factory: Index nil or empty for this device with software version (" .. var_2_1 .. "). Index registered for serv-e-go: " .. var_2_7.index)

					return false
				end

				if var_0_15(var_2_7.index, var_2_2) then
					var_0_3:info("Factory: Found an index: " .. var_2_7.index .. ". It should be greater than " .. var_0_6(var_2_2):map(string.char):join() .. " to support this device in serv-e-go.")

					return false
				end
			end

			local var_2_8 = var_0_2:create(var_2_7)

			if var_2_8 then
				for iter_2_0, iter_2_1 in pairs(var_2_8) do
					var_0_3:info("Factory : Create object parameter " .. string.format("0x%02X", iter_2_1.id) .. "(" .. iter_2_1.id .. ")-'" .. iter_2_1.name .. "' for node " .. arg_2_0.address)
					var_0_1:create(var_0_5.tableDeepCopy(iter_2_1), arg_2_0)
				end
			end

			return true
		else
			var_0_3:warning("Factory: unknown software version (" .. var_2_1 .. ") for device profile " .. var_2_0 .. ".")
		end
	end

	return false
end

return var_0_7