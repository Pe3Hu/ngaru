extends PanelContainer

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

func add_to_charge(vial, stencil):			
	for _i in stencil.flags.size():
		for _j in stencil.flags[_i].size():
			if stencil.flags[_i][_j] == "1":	
				var first_key = stencil.first_keys[_j]
				var second_key = stencil.second_keys[_i]				
				charge[first_key][second_key] += vial.charge[first_key][second_key]
				get_node("charge/"+first_key+"/"+second_key).text = String(charge[first_key][second_key])		
