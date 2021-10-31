extends Node

var player_names = ["left_player","right_player"]
var history = [ [] ]
var current = {
	"round": 0,
	"action": 0,
	"passed_player": null
	}
var last_action = {
	"left_player": false,
	"right_player": false
}
var current_action = {
	"left_player": true,
	"right_player": false
}

func switch_action():
	#print(last_action, current_action, current)		
	
	if current["passed_player"] == null:
		for player in player_names:
			current_action[player] = !current_action[player]	

func jot_pass(player):
	var action = {
		"player": player,
		"what": "pass",
		"info": {},	
		"action": current.action
	}
	
	history[current.round].append(action)
	current.action += 1
	switch_action()
	last_action[player] = true;

func jot_add(player, vial, stencil, blank):	
	var action = {
		"player": player,
		"what": "add",
		"info": {
			"vial": vial,
			"stencil": stencil,
			"blank": blank,
			},	
		"action": current.action
	}
	
	history[current.round].append(action)
	current.action += 1
	switch_action()
	#print(history)

func end_round_check():
	var flag = true
	
	for player in player_names:
		flag = last_action[player] && flag
		
	if flag:	
		current_action = {
			"left_player": true,
			"right_player": false
		}
		
		current.action = 0
		current.round += 1
		next_round()
		var timer = get_node("/root/main/global_timer")
		#timer.stop()

func next_round():
	var players = get_node("/root/main/players")
	
	for _name in player_names:
		var player = players.get_node(_name)
		player.prepare_new_round()
		
		var rows = get_node("/root/main/bg/rows/tabs/preparation/grid/"+_name+"/blanks/rows")
		rows.get_node("pass_turn").disabled = false	
		rows.get_node("pass_turn").pressed = false
		var slider =  get_node("/root/main/bg/rows/tabs/preparation/grid/"+_name+"/stencils/cols/slider")	
		slider.visible = true
		player.get_node("stencils").resize_slider()
		rows.get_node("add_to_blank").visible = true
	
	history.append([])	
	
	last_action = {
		"left_player": false,
		"right_player": false
	}
	current_action = {
		"left_player": false,
		"right_player": false
	}
	current_action[current["passed_player"]] = true
	current["passed_player"] = null

func next_action():
	var players = get_node("/root/main/players")
	for _name in player_names:
		if current_action[_name]:
			var player = players.get_node(_name)
			player.select_by_priority()
			return
