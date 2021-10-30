extends Node

var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var priorities = {
	"cargo":
		{
		"onslaught": 0, 
		"retention": 0
		},
	"recce":
		{
		"onslaught": 0, 
		"retention": 0
		},
	"feint":
		{
		"onslaught": 0, 
		"retention": 0
		},
	"depth":
		{
		"onslaught": 0, 
		"retention": 0
		},
	"spoof":
		{
		"onslaught": 0, 
		"retention": 0
		}
	}

func _ready():
	var vials = get_node("vials")
	var stencils = get_node("stencils")
	
func select_by_priority():
	var hbox = get_parent()
	var vials_slider = hbox.get_node("vials/cols/slider")
	var stencils_slider = hbox.get_node("stencils/cols/slider")
	#var blanks_slider = hbox.get_node("blanks/rows/cols/slider")
	var vials = get_node("vials").current_hand
	var stencils = get_node("stencils").current_hand
	#var blank = get_node("blanks").current_hand[blanks_slider.value]
	var combos = get_node("combos")
	
	var result = combos.fill()
	
	vials_slider.value = vials.find(result["vial"])
	stencils_slider.value = stencils.find(result["stencil"])
	print(result.value)
