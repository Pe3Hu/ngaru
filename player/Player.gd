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
	"greed": 0
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
var assessment = null
var label
var add_button
var pass_button

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
			pass_button._on_pass_turn_pressed()
			return
			
		make_assessment(result)
		
		vials_slider.value = vials.find(result["vial"])
		stencils_slider.value = stencils.find(result["stencil"])
		blanks_slider.value = blanks.find(result["blank"])
	else:
		pass_button._on_pass_turn_pressed()

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
			add_button._on_add_to_blank_pressed()
		else:
			pass_button._on_pass_turn_pressed()
		
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

func _ready():
	var rows = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name+"/blanks/rows")
	add_button = rows.get_node("add_to_blank")
	pass_button = rows.get_node("pass_turn")
