extends Node


var first_keys = ["cargo","depth","feint","recce","spoof"]
var paths = {
	"vial": "res://data/ngaru - vial.json",
	"stencil": "res://data/stencil_data.json",
	"sdiw": "res://data/ngaru - sdiw.json",
	"impact_cargo_onslaught": "res://data/ngaru - impact_cargo_onslaught.json",
	"impact_cargo_retention": "res://data/ngaru - impact_cargo_retention.json",
	"impact_depth_onslaught": "res://data/ngaru - impact_depth_onslaught.json",
	"impact_depth_retention": "res://data/ngaru - impact_depth_retention.json",
	"impact_feint_onslaught": "res://data/ngaru - impact_cargo_onslaught.json",
	"impact_feint_retention": "res://data/ngaru - impact_feint_retention.json",
	"impact_recce": "res://data/ngaru - impact_recce.json",
	"impact_spoof": "res://data/ngaru - impact_spoof.json"
}
var data = {}

func formula_res(_value, _d):
	var result = float(_d) / (_d + _value)
	if _value < 0:
		result = 2 - result
	return result
	
func formula_pen(_value, _d):
	var result = float(_d + _value) / _d
	return result

func _ready():
	
	for key in paths.keys():
		var data_file: File = File.new()
		data[key] = {}
		
		if data_file.file_exists(paths[key]):
			data_file.open(paths[key], File.READ)
			var data_json = JSON.parse(data_file.get_as_text())
			data_file.close()
			data[key] = data_json.result
