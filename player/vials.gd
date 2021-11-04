extends Node


var hand_size = 5
var deck_size = 10

var current_hand = []
var draw_deck = []
var discard_deck = []

var original_vial = preload("res://vial/vial.tscn")
var player
var preparation_hbox
var vial_types = []

var rng = RandomNumberGenerator.new()

func init_vials():	
	player = get_parent()
	preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+player.name)
	
	for _i in deck_size:
		var vial = original_vial.instance()
		rng.randomize()
		var keys = data_import.data["vial"].keys()
		var index = floor(rng.randf_range(0, keys.size()))
		var charge = data_import.data["vial"][keys[index]]
		vial.set_charge(charge)
		var parent = preparation_hbox.get_node("vials/cols/childs")
		parent.add_child(vial)
		draw_deck.append(vial)

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for vial in current_hand:
		vial.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())


func discard_hand():	
	for vial in current_hand:		
		vial.set_visible(false) 
		
	while current_hand.size() > 0:
		discard_deck.append(current_hand.pop_back())

func resize_slider():
	var slider = preparation_hbox.get_node("vials/cols/slider")
	slider.max_value = current_hand.size() - 1
		
func _ready():
	init_vials()
	fill_hand()
	resize_slider()
