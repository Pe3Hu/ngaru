extends Node


var energy = {
	"min": 0,
	"max": 100,
	"current": 50
}

func _ready():
	var vials = get_node("vials")
	var stencils = get_node("stencils")
	
func select_by_priority():
	var preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+self.name)
	var vials_slider = preparation_hbox.get_node("vials/cols/slider")
	var stencils_slider = preparation_hbox.get_node("stencils/cols/slider")
	var blanks_slider = preparation_hbox.get_node("blanks/rows/cols/slider")
	var vials = get_node("vials").current_hand
	var stencils = get_node("stencils").current_hand
	var blanks = get_node("blanks").current_hand
	var combos = get_node("combos")
	
	var result = combos.fill()
	
	vials_slider.value = vials.find(result["vial"])
	stencils_slider.value = stencils.find(result["stencil"])
	blanks_slider.value = blanks.find(result["blank"])
	
	print(result.value)
