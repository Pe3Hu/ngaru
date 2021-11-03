extends Node

var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var players
var breakaways
	
func compute_breakaways():
	breakaways = {}
	
	for _s_key in second_keys:
		var advantage = players.get_node(_s_key)
		
		for _f_key in first_keys:
			var koef = 0
			
			if _s_key == "onslaught":
				breakaways[_f_key] = 0
			
			match _s_key:
				"onslaught":
					koef = 1
				"retention":
					koef = -1
					
			breakaways[_f_key] += advantage.nodes[_f_key]["value"] * koef
	
	for key in breakaways.keys():
		breakaways[key] = sign(breakaways[key]) * floor(sqrt(abs(breakaways[key])))
	
	update_labels()
	
func update_labels():
	clean_labels()
	
	var grid = players.get_node("breakaways/grid")
	
	for _f_key in breakaways.keys():
		var _s_key
		var _sign = int(sign(breakaways[_f_key]))
		
		match _sign:
			-1:
				_s_key = "retention"
			1:
				_s_key = "onslaught"
				
		if _sign != 0:
			var label = grid.get_node(_f_key+"/cols/"+_s_key)
			var txt = ""
			
			if breakaways[_f_key] > 0:
				txt = "+"
				
			label.text = txt + str(breakaways[_f_key])

func clean_labels():
	var grid = players.get_node("breakaways/grid")
	
	for _f_key in first_keys:
		for _s_key in second_keys:
			var label = grid.get_node(_f_key+"/cols/"+_s_key)
			label.text = ""

func _ready():
	players = get_node("/root/main/bg/rows/tabs/impact/players")
	
	var grid = players.get_node("breakaways/grid")
		
	for _f_key in first_keys:
		for _s_key in second_keys:
			var label = grid.get_node(_f_key+"/cols/"+_s_key)
			label.set_custom_minimum_size(Vector2(15,15))
