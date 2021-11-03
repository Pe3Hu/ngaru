extends Node
 
var first_keys = ["capacity", "resistance", "replenishment", "inside", "outside", "reaction"]
var second_keys = ["S", "D", "I", "W"]
var arguments = {
	"capacity":
		{
		"S":
			{
				"name": "vitality",
				"value": 0
			},
		"D":
			{
				"name": "plasticity",
				"value": 0
			},
		"I":
			{
				"name": "erudition",
				"value": 0
			},
		"W":
			{
				"name": "mood",
				"value": 0
			}
		},	
	"resistance":
		{
		"S":
			{
				"name": "fastness",
				"value": 0
			},
		"D":
			{
				"name": "immediacy",
				"value": 0
			},
		"I":
			{
				"name": "invention",
				"value": 0
			},
		"W":
			{
				"name": "sangfroid",
				"value": 0
			}
		},	
	"replenishment":
		{
		"S":
			{
				"name": "regeneration",
				"value": 0
			},
		"D":
			{
				"name": "massage",
				"value": 0
			},
		"I":
			{
				"name": "meditation",
				"value": 0
			},
		"W":
			{
				"name": "mantra",
				"value": 0
			}
		},	
	"inside":
		{
		"S":
			{
				"name": "diversion",
				"value": 0
			},
		"D":
			{
				"name": "postiche",
				"value": 0
			},
		"I":
			{
				"name": "disinformation",
				"value": 0
			},
		"W":
			{
				"name": "bluff",
				"value": 0
			}
		},	
	"outside":
		{
		"S":
			{
				"name": "savvy",
				"value": 0
			},
		"D":
			{
				"name": "advertence",
				"value": 0
			},
		"I":
			{
				"name": "observancy",
				"value": 0
			},
		"W":
			{
				"name": "prophecy",
				"value": 0
			}
		},	
	"reaction":
		{
		"S":
			{
				"name": "instinct",
				"value": 0
			},
		"D":
			{
				"name": "reflex",
				"value": 0
			},
		"I":
			{
				"name": "prescience",
				"value": 0
			},
		"W":
			{
				"name": "intuition",
				"value": 0
			}
		}	
	}

func _ready():
	var default_value = 10
	
	for _f_key in first_keys:
		for _s_key in second_keys:
			arguments[_f_key][_s_key]["value"] = default_value
	
func add_to_argumetn(_f_key, _s_key, _value):
	arguments[_f_key][_s_key]["value"] += _value
	
func get_argumetn(_f_key, _s_key, _value):
	return arguments[_f_key][_s_key]["value"]
