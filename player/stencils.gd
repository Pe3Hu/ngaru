extends Node

var hand_size = 4
var deck_size = 8

var current_hand = []
var draw_deck = []
var discard_deck = []

var path_stencil_types = "res://stencil/stencil_types.json"
var original_stencil = preload("res://stencil/stencil.tscn")
var player
var preparation_hbox
var stencil_types = []

var rng = RandomNumberGenerator.new()

func save():
	var save_data = File.new()	
	var dictionary = {
		"binary": [],
		"int": []	
		}			
		
	var l = 2 * 5 - 1	
	for i in 2:
		for j in 5:
			if(j > 0):
				var txt = "0000000000"
				txt[l-i*5] = "1"
				txt[l-i*5-j] = "1"
				dictionary["binary"].append(txt)
				
		for j in 5:
			if(j == 1) or (j == 2):		
				var txt = "0000000000"			
				txt[l-i*5-j] = "1"		
				txt[l-(i+1)*5+j] = "1"
				dictionary["binary"].append(txt)
				
	for txt in dictionary["binary"]:		
		var n = 0
		var d = 512
		
		for j in txt:			
			if(j == "1"):
				n+=d
			d/=2
		
		dictionary["int"].append(n)	
		
	save_data.open("res://stencil/stencil_types.json", File.WRITE)
	save_data.store_line(to_json(dictionary))
	save_data.close()
	
func load_stencil_types():
	var open_file: File = File.new()	
	
	if not open_file.file_exists(path_stencil_types):
		return
		
	open_file.open(path_stencil_types, File.READ)	
	
	while open_file.get_position() < open_file.get_len():
		var data: Dictionary = parse_json(open_file.get_line())
		stencil_types.push_back(data)
	
func init_stencils():	
	load_stencil_types()
	player = get_parent()
	preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+player.name)
	
	for _i in deck_size:
		var stencil = original_stencil.instance()
		rng.randomize()
		var _j = 0;
		var index = floor(rng.randf_range(0, stencil_types[_j]["binary"].size()))
		var type = stencil_types[_j]["binary"][index]
		stencil.set_flags(type)
		var parent = preparation_hbox.get_node("stencils/cols/childs")
		parent.add_child(stencil)
		draw_deck.append(stencil)

func fill_hand():
	while current_hand.size() < hand_size:
		draw_from_deck()
	
	for stencil in current_hand:		
		stencil.set_visible(true) 

func draw_from_deck():
	if(draw_deck.size() == 0):
		draw_deck += discard_deck
		rng.randomize()	
		draw_deck.shuffle()
		discard_deck = []
		
	current_hand.append(draw_deck.pop_back())

func resize_slider():
	var slider = preparation_hbox.get_node("stencils/cols/slider")
	slider.max_value = current_hand.size() - 1

func discard_hand():	
	for stencil in current_hand:		
		stencil.set_visible(false) 
		
	while current_hand.size() > 0:
		discard_deck.append(current_hand.pop_back())
		
func _ready():
	init_stencils()
	fill_hand()
	resize_slider()
