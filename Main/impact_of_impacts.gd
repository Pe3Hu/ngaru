extends Node


var first_keys = ["cargo","feint","depth","recce","spoof"]
var second_keys = ["onslaught","retention"]
var third_keys = ["cargo","feint","depth","retention_secret","onslaught_secret"]
var advantages
var breakaways

func init_impact():
	compute_breakaways()
	
	for _s_key in second_keys:
		var advantage = advantages.get_node(_s_key)
		advantage.set_options()
		
	compute_efficiency_multipliers()
	
func compute_breakaways():
	breakaways = {}
	
	for _s_key in second_keys:
		var advantage = advantages.get_node(_s_key)
		
		for _i in third_keys.size():
			var koef = 0
			
			if _s_key == "onslaught":
				breakaways[third_keys[_i]] = 0
			
			var value = advantage.nodes[first_keys[_i]]["value"]
			
			match _s_key:
				"onslaught":
					koef = 1
				"retention":
					koef = -1
					
					match first_keys[_i]:
						"recce":
							value = advantage.nodes[first_keys[_i+1]]["value"]
						"spoof":
							value = advantage.nodes[first_keys[_i-1]]["value"]

			breakaways[third_keys[_i]] += value * koef
	
	for key in breakaways.keys():
		breakaways[key] = sign(breakaways[key]) * floor(sqrt(abs(breakaways[key])))
	
	update_labels()

func compute_efficiency_multipliers():	
	for _i in second_keys.size():
		var _key = second_keys[_i];
		var _j = (_i + 1) % second_keys.size()
		var _another_key = second_keys[_j]
		var advantage = advantages.get_node(_key)
		var another_advantage = advantages.get_node(_another_key)
		var n = advantage.player.get_node("sdiw").milestones["inside"] * (1 + advantage.nodes["spoof"]["sqrt_value"])
		var m = another_advantage.player.get_node("sdiw").milestones["outside"] * (1 + another_advantage.nodes["recce"]["sqrt_value"])
	
		advantage.efficiency_multiplier = n/m
		
	
func update_labels():
	clean_labels()
	
	var grid = advantages.get_node("breakaways/grid")
	
	for _t_key in third_keys:
		var _s_key
		var _sign = int(sign(breakaways[_t_key]))
		
		match _sign:
			-1:
				_s_key = "retention"
			1:
				_s_key = "onslaught"
				
		if _sign != 0:
			var label = grid.get_node(_t_key+"/cols/"+_s_key)
			
			label.text = "+" + str(abs(breakaways[_t_key]))

func clean_labels():
	var grid = advantages.get_node("breakaways/grid")
	
	for _t_key in third_keys:
		for _s_key in second_keys:
			var label = grid.get_node(_t_key+"/cols/"+_s_key)
			label.text = ""

func _ready():
	advantages = get_node("/root/main/bg/rows/tabs/impact/players")
	
	var grid = advantages.get_node("breakaways/grid")
		
	for _t_key in third_keys:
		for _s_key in second_keys:
			var label = grid.get_node(_t_key+"/cols/"+_s_key)
			label.set_custom_minimum_size(Vector2(15,15))
