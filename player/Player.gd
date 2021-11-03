extends Node


var stamina = {
	"min": 0,
	"max": 100,
	"current": 50,
	"inc": 2
}
var current = {
	"counter": 1,
	"stamina_price": 1
}
var sins = {
	"pride": 1,
	"greed": 1
}
var tendency = {
	"cargo": 4, 
	"recce": 1,
	"feint": 1,
	"depth": 1,
	"spoof": 1,		
	"onslaught": 1,
	"retention" : 1
}
var confines = {
	"pride": [
		{
			"min": 0,
			"max": 100
		},		
		{
			"min": 15,
			"max": 100
		},
		{
			"min": 35,
			"max": 100
		},
		{
			"min": 60,
			"max": 100
		},
		{
			"min": 90,
			"max": 100
		}
	],	
	"greed": [ 0.55, 0.7, 0.85, 1, 1.15 ]
}
var impact_criteria = {
	"onslaught": {
		"cargo": 4
	}
	#,"retention"
}
var assessment = null
var label
var buttons = {
	"add": null,
	"pass": null,
	"activate": null
}
var order

var rng = RandomNumberGenerator.new()

func select_by_priority():
	if stamina["current"] > current["stamina_price"]:
		var preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name)
		var vials_slider = preparation_hbox.get_node("vials/cols/slider")
		var stencils_slider = preparation_hbox.get_node("stencils/cols/slider")
		var blanks_slider = preparation_hbox.get_node("blanks/rows/cols/slider")
		var vials = get_node("vials").current_hand
		var stencils = get_node("stencils").current_hand
		var blanks = get_node("blanks").current_hand
		var combos = get_node("combos")
		
		var result = combos.fill()
		
		if result == null:
			buttons["pass"]._on_pass_turn_pressed()
			return
		
		vials_slider.value = vials.find(result["vial"])
		stencils_slider.value = stencils.find(result["stencil"])
		blanks_slider.value = blanks.find(result["blank"])
		make_assessment(result)
	else:
		buttons["pass"]._on_pass_turn_pressed()

func make_assessment(result):
	var mark = round(result.value / result.max_value * 100)
	
	var _sin = "pride"
	var _c = confines[_sin][sins[_sin]]
	#pride check
	if mark >= _c.min && mark <= _c.max:
		_sin = "greed"
		var power = confines[_sin][sins[_sin]]
		var _min = 1/pow(current["counter"], power)
		rng.randomize()
		var rnd = rng.randf_range(0,1)
		#greed check
		if rnd <= _min:
			buttons["add"]._on_add_to_blank_pressed()
		else:
			buttons["pass"]._on_pass_turn_pressed()

func prepare_new_round():
	var vials = get_node("vials")
	var stencils = get_node("stencils")
	
	vials.discard_hand()
	vials.fill_hand()
	stencils.discard_hand()
	stencils.fill_hand()	
	
	current["counter"] = 1
	current["stamina_price"] = 1
	stamina["current"] += stamina["inc"]

func find_blank_for_activate(second_key):
	var result = {
		"index": -1,
		"value": -1,
		"blank": null
	}
	var first_key = "cargo"
	
	var preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name)
	var blanks_slider = preparation_hbox.get_node("blanks/rows/cols/slider")
	var blanks = get_node("blanks").current_hand
	
	for _i in blanks.size():
		if result["value"] < blanks[_i].charge[first_key][second_key] && blanks[_i].archetype == second_key:
			result = {
				"index": _i,
				"value": blanks[_i].charge[first_key][second_key],
				"blank": blanks[_i]
			}
	
	return result

func impact_check():
	var flag = false
	var first_key
	
	if order.impact_flag:
		first_key = "retention"
		flag = true
	else:
		first_key = "onslaught"
		var result = find_blank_for_activate(first_key)
		
		if result["value"] > impact_criteria[first_key]["cargo"]:
			flag = true
	
	if flag:
		reaction_to_impact(first_key)
	else:
		select_by_priority()

func reaction_to_impact(first_key):	
	var result = find_blank_for_activate(first_key)
	
	var blanks_slider = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name+"/blanks/rows/cols/slider")
	blanks_slider.value = result.index
	buttons["activate"]._on_activate_blank_pressed()

func _ready():
	order = get_node("/root/main/order_of_orders")
	var rows = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name+"/blanks/rows")
	buttons["add"] = rows.get_node("add_to_blank")
	buttons["pass"] = rows.get_node("pass_turn")
	buttons["activate"] = rows.get_node("activate_blank")
