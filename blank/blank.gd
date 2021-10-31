extends PanelContainer

var index
var charge = {
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
var priorities
var first_keys = ["cargo","recce","feint","depth","spoof"]
var second_keys = ["onslaught","retention"]

var rng = RandomNumberGenerator.new()

func _ready():
	var priorities_name
	
	match index:
		0:
			priorities_name = "onslaught"
		1:
			priorities_name = "retention"
		2:
			rng.randomize()	
			var index = floor(rng.randf_range(0, first_keys.size()))
			priorities_name = first_keys[index]
			
	set_priorities(priorities_name)	

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
		"onslaught":		
			priorities["cargo"]["onslaught"] = 10	
			priorities["recce"]["onslaught"] = 7	
			priorities["feint"]["onslaught"] = 8	
			priorities["depth"]["onslaught"] = 9	
			priorities["spoof"]["onslaught"] = 6	
		"retention":		
			priorities["cargo"]["retention"] = 10	
			priorities["recce"]["retention"] = 7	
			priorities["feint"]["retention"] = 8	
			priorities["depth"]["retention"] = 9	
			priorities["spoof"]["retention"] = 6	
		"cargo":		
			priorities["cargo"]["onslaught"] = 10	
			priorities["cargo"]["retention"] = 10	
		"recce":		
			priorities["recce"]["onslaught"] = 10	
			priorities["recce"]["retention"] = 10	
		"feint":		
			priorities["feint"]["onslaught"] = 10	
			priorities["feint"]["retention"] = 10	
		"depth":		
			priorities["depth"]["onslaught"] = 10	
			priorities["depth"]["retention"] = 10	
		"spoof":		
			priorities["spoof"]["onslaught"] = 10	
			priorities["spoof"]["retention"] = 10	

func add_to_charge(vial, stencil):			
	for _i in stencil.flags.size():
		for _j in stencil.flags[_i].size():
			if stencil.flags[_i][_j] == "1":	
				var first_key = stencil.first_keys[_j]
				var second_key = stencil.second_keys[_i]				
				charge[first_key][second_key] += vial.charge[first_key][second_key]
				get_node("charge/"+first_key+"/"+second_key).text = String(charge[first_key][second_key])		
