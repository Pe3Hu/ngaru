extends Node

func set_charge(charge):		
	for first_key in charge:		
		for second_key in charge[first_key]:	
			get_node("charge/"+first_key+"/"+second_key).text = String(charge[first_key][second_key])

func set_position(vec):	
	get_node("charge").rect_position = vec
	
func set_visible(flag):	
	get_node("charge").visible = flag

func _ready():
	pass # Replace with function body.
