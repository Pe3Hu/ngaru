extends PanelContainer

var charge

func set_charge(_charge):		
	charge = _charge
	
	for first_key in _charge:		
		for second_key in _charge[first_key]:	
			get_node("charge/"+first_key+"/"+second_key).text = String(_charge[first_key][second_key])
	
func set_visible(flag):	
	visible = flag
