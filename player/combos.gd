extends Node

var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var vials_hand
var stencils_hand
var all_combos
var priorities

var rng = RandomNumberGenerator.new()

func _ready():
	set_priorities("priorities_1")

func fill():	
	vials_hand = get_parent().get_node("vials").current_hand
	stencils_hand = get_parent().get_node("stencils").current_hand
	all_combos = {}
	
	for vial in vials_hand:
		all_combos[vial] = {}
		
		for stencil in stencils_hand:			
			var charge  = {}
			
			for _i in stencil.flags.size():
				for _j in stencil.flags[_i].size():				
					if stencil.flags[_i][_j] == "1":	
						var first_key = stencil.first_keys[_j]
						var second_key = stencil.second_keys[_i]	
						if charge.keys().find(first_key)	== -1:		
							charge[first_key] = {}
						charge[first_key][second_key] = vial.charge[first_key][second_key]
									
			all_combos[vial][stencil] = charge			
	
	return sort_by_priority()		

func sort_by_priority():
	var priority_values = []
	
	for vial in all_combos.keys():
		for stencil in all_combos[vial].keys():
			var combo = all_combos[vial][stencil]
			var value = 0
			
			for _f_key in combo.keys():
				for _s_key in combo[_f_key].keys():
					value += pow( combo[_f_key ][_s_key], 2 ) * priorities[_f_key][_s_key]
					
					
			var obj = {
				"vial": vial,
				"stencil": stencil,
				"value": value
			}
					
			priority_values.append( obj )
	
	priority_values.sort_custom(MyCustomSorter, "sort_ascending")	
	var result = get_random_by_values(priority_values)			
	return result
	
class MyCustomSorter:
	static func sort_ascending(a, b):
		if a["value"] < b["value"]:
			return true
		return false			

func get_random_by_values(arr):
	var indexs = []
	
	for _i in arr.size():
		for _j in arr[_i]["value"]:
			indexs.append(_i)
	
	rng.randomize()	
	
	var l = indexs.size()
	
	if indexs.size() == 0:
		l = arr.size()
		
	var index = floor(rng.randf_range(0, l))	
	var result
	
	if indexs.size() == 0:
		result = arr[index]
	else:	
		result = arr[indexs[index]]
		
	return result

func set_priorities(_priorities):
	var default_value = 0
	
	priorities = {
		"cargo":
			{
			"onslaught": default_value, 
			"retention": default_value
			},
		"recce":
			{
			"onslaught": default_value, 
			"retention": default_value
			},
		"feint":
			{
			"onslaught": default_value, 
			"retention": default_value
			},
		"depth":
			{
			"onslaught": default_value, 
			"retention": default_value
			},
		"spoof":
			{
			"onslaught": default_value, 
			"retention": default_value
			},
		}
	
	match _priorities:
		"priorities_0":
			priorities = {
				"cargo":{
					"onslaught": 10, 
					"retention": 5
					},
				"recce":
					{"onslaught": 9, 
					"retention": 4
					},
				"feint":
					{"onslaught": 8, 
					"retention": 3
					},
				"depth":
					{"onslaught": 7, 
					"retention": 2},
				"spoof":
					{"onslaught": 6, 
					"retention": 1
					}
				}		
		"priorities_1":		
			priorities["cargo"]["onslaught"] = 10	
			priorities["recce"]["onslaught"] = 7	
			priorities["feint"]["onslaught"] = 8	
			priorities["depth"]["onslaught"] = 9	
			priorities["spoof"]["onslaught"] = 6	
		"priorities_2":		
			priorities["cargo"]["retention"] = 10	
			priorities["recce"]["retention"] = 7	
			priorities["feint"]["retention"] = 8	
			priorities["depth"]["retention"] = 9	
			priorities["spoof"]["retention"] = 6	
