extends Control

var order_of_moves
var timer
var time_stop = false

func _ready():
	timer =  get_node("global_timer")
	timer.set_wait_time(0.1)
	timer.start()
	
	order_of_moves = get_node("order_of_moves")

func _on_global_timer_timeout():
	order_of_moves.next_action()
	#timer.stop()
