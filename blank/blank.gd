extends PanelContainer

var charge = {
	"cargo":{
		"onslaught": 0, 
		"retention": 0},
	"recce":
		{"onslaught": 0, 
		"retention": 0},
	"feint":
		{"onslaught": 0, 
		"retention": 0},
	"depth":
		{"onslaught": 0, 
		"retention": 0},
	"spoof":
		{"onslaught": 0, 
		"retention": 0}
		}

func add_to_charge(_charge):		
	charge = _charge
	
	for first_key in _charge:		
		for second_key in _charge[first_key]:	
			charge[first_key][second_key] += _charge[first_key][second_key]
			get_node("charge/"+first_key+"/"+second_key).text = String(charge[first_key][second_key])
