extends PanelContainer


var charge

func set_charge(_charge):
	charge = {}
	
	for key in _charge:
		var keys = key.split("_", true, 1)
		var first_key = keys[0]
		var second_key = keys[1]
		
		get_node("charge/"+first_key+"/"+second_key).text = String(_charge[key])
		
		if charge.keys().find(first_key) == -1:
			charge[first_key] = {}
		charge[first_key][second_key] = _charge[key]
	
func set_visible(flag):
	visible = flag
