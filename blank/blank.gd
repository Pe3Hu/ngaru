extends PanelContainer

var index
var charge
var priorities
var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]
var archetype

var rng = RandomNumberGenerator.new()

func _ready():
	clean()
	var priorities_name
	
	match index:
		0:
			archetype = "onslaught"
			priorities_name = "_"+archetype
		1:
			archetype = "retention"
			priorities_name = "_"+archetype
		2:
			archetype = "buff"
			rng.randomize()
			var _index = floor(rng.randf_range(0, first_keys.size()))
			priorities_name = "_"+first_keys[_index]
			
	set_priorities(priorities_name)	

func set_priorities(_priorities):
	var default_value = 0
	
	priorities = {}
	
	for _f_key in first_keys:
		priorities[_f_key] = {}
		
		for _s_key in second_keys:
			priorities[_f_key][_s_key] = default_value
		
	match _priorities:
		"_onslaught":		
			priorities["cargo"]["onslaught"] = 10	
			priorities["recce"]["onslaught"] = 7	
			priorities["feint"]["onslaught"] = 8	
			priorities["depth"]["onslaught"] = 9	
			priorities["spoof"]["onslaught"] = 6	
		"_retention":		
			priorities["cargo"]["retention"] = 10	
			priorities["recce"]["retention"] = 7	
			priorities["feint"]["retention"] = 8	
			priorities["depth"]["retention"] = 9	
			priorities["spoof"]["retention"] = 6	
		"_cargo":		
			priorities["cargo"]["onslaught"] = 10	
			priorities["cargo"]["retention"] = 10	
		"_recce":		
			priorities["recce"]["onslaught"] = 10	
			priorities["recce"]["retention"] = 10	
		"_feint":		
			priorities["feint"]["onslaught"] = 10	
			priorities["feint"]["retention"] = 10	
		"_depth":		
			priorities["depth"]["onslaught"] = 10	
			priorities["depth"]["retention"] = 10	
		"_spoof":		
			priorities["spoof"]["onslaught"] = 10	
			priorities["spoof"]["retention"] = 10	

func add_to_charge(vial, stencil):			
	for _i in stencil.flags.size():
		for _j in stencil.flags[_i].size():
			if stencil.flags[_i][_j] == "1":	
				var first_key = stencil.first_keys[_j]
				var second_key = stencil.second_keys[_i]				
				charge[first_key][second_key] += vial.charge[first_key][second_key]
				get_node("charge/"+first_key+"/"+second_key).text = str(charge[first_key][second_key])		

func clean():
	charge = {}
	
	for _f_key in first_keys:
		charge[_f_key] = {}
		
		for _s_key in second_keys:
			charge[_f_key][_s_key] = 0
			get_node("charge/"+_f_key+"/"+_s_key).text = str(charge[_f_key][_s_key])
