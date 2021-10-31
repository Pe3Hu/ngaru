extends Node

var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var vials_hand
var stencils_hand
var blanks_hand
var all_combos
var priorities

var rng = RandomNumberGenerator.new()

func fill():
	vials_hand = get_parent().get_node("vials").current_hand
	stencils_hand = get_parent().get_node("stencils").current_hand
	blanks_hand = get_parent().get_node("blanks").current_hand
	all_combos = {}
	
	for blank in blanks_hand:
		all_combos[blank] = {}
		
		for vial in vials_hand:
			all_combos[blank][vial] = {}
			
			for stencil in stencils_hand:
				var charge  = {}
				
				for _i in stencil.flags.size():
					for _j in stencil.flags[_i].size():
						if stencil.flags[_i][_j] == "1":
							var first_key = stencil.first_keys[_j]
							var second_key = stencil.second_keys[_i]
							if charge.keys().find(first_key) == -1:
								charge[first_key] = {}
							charge[first_key][second_key] = vial.charge[first_key][second_key]
										
				all_combos[blank][vial][stencil] = charge
	
	return sort_by_priority()		

func sort_by_priority():
	var priority_values = []
	
	for blank in all_combos.keys():
		for vial in all_combos[blank].keys():
			for stencil in all_combos[blank][vial].keys():
				var combo = all_combos[blank][vial][stencil]
				var value = 0
				
				for _f_key in combo.keys():
					for _s_key in combo[_f_key].keys():
						value += pow( combo[_f_key ][_s_key], 2 ) * blank.priorities[_f_key][_s_key]					
				
				if value > 0:
					var obj = {
						"vial": vial,
						"stencil": stencil,
						"value": value,
						"blank": blank
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
	if arr.size() == 0:
		return null
		
	var indexs = []
	var _max = 0
	
	for _i in arr.size():
		for _j in arr[_i]["value"]:
			indexs.append(_i)
		
		if arr[_i]["value"] > _max:
			_max = arr[_i]["value"]
	
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
	
	result["max_value"] = _max
	return result
