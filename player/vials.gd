extends Node

var hand_size = 5
var deck_size = 10

var current_hand = []
var draw_deck = []
var discard_deck = []

var path_vial_types = "res://vial/vial_types.json"
var original_vial = preload("res://vial/vial.tscn")
var vial_types = []
var charge
var rng = RandomNumberGenerator.new()
	
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
		var parent = get_parent().get_parent().get_node("vials/cols/childs")
		parent.add_child(vial)
		draw_deck.append(vial)

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for vial in current_hand:		
		var index = current_hand.find(vial,0)
		vial.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()	
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())

func resize_slider():
	var slider = get_parent().get_parent().get_node("vials/cols/slider")
	slider.max_value = current_hand.size() - 1
		
func _ready():
	init_vials()
	fill_hand()
	resize_slider()
