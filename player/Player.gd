extends Node

var x_start = 8
var y_start = 8
var offset = 52

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
	
	save_data.open(path_vial_types, File.WRITE)
	save_data.store_line(to_json(charge))
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
		vial.set_charge(vial_types[index])
		add_child(vial)
		draw_deck.append(vial)
	
	print(draw_deck)

func grid_to_pixel(index):
	var x = x_start + offset * 0;	
	var y = y_start + offset * index;	
	return Vector2(x, y);

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for vial in current_hand:		
		var index = current_hand.find(vial,0)
		vial.set_position(grid_to_pixel(index))
		vial.set_visible(true) 
	print(current_hand)	

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

