extends Node

var hand_size = 3
var deck_size = 3

var current_hand = []
var draw_deck = []
var discard_deck = []

var original_blank = preload("res://blank/blank.tscn")
var rng = RandomNumberGenerator.new()
	
func init_blanks():		
	for n in deck_size:
		var blank = original_blank.instance()		
		var parent = get_parent().get_parent().get_node("blanks/childs")
		parent.add_child(blank)
		draw_deck.append(blank)

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for blank in current_hand:		
		var index = current_hand.find(blank,0)
		blank.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()	
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())
		
func _ready():
	init_blanks()
	fill_hand()
