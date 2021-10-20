extends Node

var vial_offset = 56
var panel_offset = 12

var hand_size = 5
var deck_size = 10

var current_hand = []
var draw_deck = []
var discard_deck = []

var path_vial_types = "res://vial/vial_types.json"
var original_vial = preload("res://vial/Vial.tscn")
var vial_types = []
var charge
var rng = RandomNumberGenerator.new()
	
func save():
	var save_data = File.new()	
	var dictionary = {
		"2":{
			"binary": [],
			"int": []	
			}	
		}
		
	var l = 2 * 5 - 1	
	for i in 2:
		for j in 5:
			if(j > 0):
				var txt = "0000000000"
				txt[l-i*5] = "1"
				txt[l-i*5-j] = "1"
				dictionary["2"]["binary"].append(txt)
				
		for j in 5:
			if(j == 1) or (j == 2):		
				var txt = "0000000000"			
				txt[l-i*5-j] = "1"		
				txt[l-(i+1)*5+j] = "1"
				dictionary["2"]["binary"].append(txt)
				
	for txt in dictionary["2"]["binary"]:		
		var n = 0
		var d = 512
		
		for j in txt:			
			if(j == "1"):
				n+=d
			d/=2
		
		dictionary["2"]["int"].append(n)	
		
	save_data.open("res://stencil/stencil_types.json", File.WRITE)
	save_data.store_line(to_json(dictionary))
	save_data.close()
	
func load_vial_types():
	var open_file: File = File.new()	
	
	if not open_file.file_exists(path_vial_types):
		return
		
	open_file.open(path_vial_types, File.READ)	
	
	while open_file.get_position() < open_file.get_len():
		var data: Dictionary = parse_json(open_file.get_line())
		vial_types.push_back(data)	
	
func init_vials():	
	load_vial_types()
	
	for n in deck_size:
		var vial = original_vial.instance()		
		rng.randomize()	
		var index = floor(rng.randf_range(0, vial_types.size()))
		var charge = vial_types[index]
		vial.set_charge(charge)
		add_child(vial)
		draw_deck.append(vial)

func grid_to_pixel(index):	
	var parent = get_parent()
	var x_start = parent.get_rect().position.x
	var y_start = parent.get_rect().position.y
	var x = x_start + panel_offset;	
	var y = y_start + panel_offset + vial_offset * index;	
	return Vector2(x, y);

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for vial in current_hand:		
		var index = current_hand.find(vial,0)
		vial.set_position(grid_to_pixel(index))
		vial.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()	
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())
		
func _ready():
	init_vials()
	fill_hand()
	save()
