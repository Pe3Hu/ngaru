extends PanelContainer


var first_keys = ["cargo","depth","feint","recce","spoof"]
var nodes
var options
var player
var efficiency_multiplier

func _ready():
	init_node()

func init_node():
	nodes = {}
	options = {}
	
	for _f_key in first_keys:
		nodes[_f_key] = {
			"value_node": get_node("rows/values/"+_f_key),
			"value": 0,
			"sqrt_value": 0,
			"options_node": get_node("rows/options/"+_f_key),
			"selected_option": -1
		}
		
		var text = "impact_" + _f_key
		
		match _f_key:
			"cargo","depth","feint":
				text += "_" + self.name
				
		var data = data_import.data[text]
		
		if data != null:
			options[_f_key] = {}
			
			for _name in data:
				options[_f_key][_name] = data[_name]
	
func set_options():
	for _f_key in first_keys:
		for _name in options[_f_key]:
			if options[_f_key][_name]["price"] <= nodes[_f_key]["sqrt_value"]:
				nodes[_f_key]["options_node"].add_item(_name)

func set_values(blank, player_name):
	player =  get_node("/root/main/players/"+player_name)
	
	for _f_key in first_keys:
		nodes[_f_key]["value"] = blank.charge[_f_key][self.name] 
		nodes[_f_key]["sqrt_value"] = floor(sqrt(blank.charge[_f_key][self.name])) 
		update_label(_f_key)

func update_label(key):
	nodes[key]["value_node"].text = str(nodes[key]["sqrt_value"])

func _on_cargo_item_selected(index):
	nodes["cargo"]["value"] -= 1
	update_label("cargo")
