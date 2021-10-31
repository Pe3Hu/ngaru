extends PanelContainer

var type = ["onslaught","retention"]
var first_keys = ["cargo","recce","feint","depth","spoof"]
var nodes

func _ready():
	init_node()
	set_basic_buffs()

func init_node():
	nodes = {}
	
	for _f_key in first_keys:
		nodes[_f_key] = {
			"value_node": get_node("rows/values/"+_f_key),
			"value": 0,
			"options_node": get_node("rows/options/"+_f_key),
			"selected_option": -1
		}
	
func set_basic_buffs():
	for _f_key in first_keys:
		nodes[_f_key]["options_node"].add_item("basic_buff")

func set_values(blank):
	for _f_key in first_keys:
		nodes[_f_key]["value"] = blank.charge[_f_key][self.name] 
		update_label(_f_key)

func update_label(key):
	nodes[key]["value_node"].text = str(nodes[key]["value"])

func _on_cargo_item_selected(index):
	nodes["cargo"]["value"] -= 1
	update_label("cargo")
