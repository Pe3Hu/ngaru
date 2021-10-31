extends Control

var left_player
var right_player
var timer
var time_stop = false

func _ready():
	timer =  get_node("global_timer")
	timer.set_wait_time(1)
	timer.start()
	
	left_player = get_node("players/left_player")
	right_player = get_node("players/right_player")
	print()

func _process(delta):
	pass

func _on_global_timer_timeout():
	left_player.select_by_priority()
	timer.stop()
