extends Node
 

var fifth_keys = ["capacity","resistance","tension","replenishment","inside","outside","reaction"]
var sixth_keys = ["S","D","I","W"]
var arguments
var milestones

var rng = RandomNumberGenerator.new()

func add_to_argument(_f_key, _s_key, _value):
	arguments[_f_key][_s_key]["value"] += _value
	
func get_argument(_f_key, _s_key):
	return arguments[_f_key][_s_key]["value"]

func init_sdiw():
	var default_value = 10
	var counts = [1,2,3,5,5,3,2,1]
	var values = [-4,-3,-2,-1,1,2,3,4]
	var bias = []
	
	for _i in values.size():
		for _j in counts[_i]:
			bias.append(values[_i])
	
	var l = fifth_keys.size() * sixth_keys.size()
	
	while bias.size() < l:
		bias.append(0)
	
	bias.shuffle()
	var _i = 0
	
	arguments = {}
	
	for _f_key in fifth_keys:
		arguments[_f_key] = {}
		
		for _s_key in sixth_keys:
			arguments[_f_key][_s_key] = {
				"name": data_import.data["sdiw"][_f_key][_s_key],
				"value": default_value + bias[_i]
			}
			
			_i += 1

func update_milestones():
	milestones = {}
	
	for _s_key in sixth_keys:
		milestones[_s_key] = 0
	
	for _f_key in fifth_keys:
		milestones[_f_key] = 0
		
		for _s_key in sixth_keys:
			milestones[_f_key] += arguments[_f_key][_s_key]["value"]
			milestones[_s_key] += arguments[_f_key][_s_key]["value"]
	
	print(milestones)
	
func _ready():
	init_sdiw()
	update_milestones()
