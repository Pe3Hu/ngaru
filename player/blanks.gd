extends Node

var hand_size = 2
var deck_size = 2

var current_hand = []
var draw_deck = []
var discard_deck = []

var original_blank = preload("res://blank/blank.tscn")
var player
var preparation_hbox

var rng = RandomNumberGenerator.new()
	
func init_blanks():		
	player = get_parent()
	preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+player.name)
	
	for _i in deck_size:
		var blank = original_blank.instance()		
		blank.index = _i
		var parent = preparation_hbox.get_node("blanks/rows/cols/childs")
		parent.add_child(blank)
		draw_deck.append(blank)

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for blank in current_hand:		
		blank.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()	
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())
		
func resize_slider():
	var slider = preparation_hbox.get_node("blanks/rows/cols/slider")
	slider.max_value = current_hand.size() - 1
		
func _ready():
	init_blanks()
	fill_hand()
	resize_slider()
