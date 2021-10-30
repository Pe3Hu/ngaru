extends PanelContainer

var binary_type
var first_keys = ["cargo", "recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var flags = []

func set_flags(_binary_type):		
	binary_type = _binary_type	
	
	var binarys = []
	
	for letter in _binary_type:
		binarys.append(letter)
	
	flags = [ 
		binarys.slice(0, binarys.size()/2 - 1), 
		binarys.slice(binarys.size()/2, binarys.size()) 
		]
	
	for _i in flags.size():
		for _j in flags[_i].size():
			if flags[_i][_j] == "1":
				var check_box = get_node("flags/"+first_keys[_j]+"/"+second_keys[_i])				
				check_box.pressed = true	
	
func set_visible(flag):	
	visible = flag
