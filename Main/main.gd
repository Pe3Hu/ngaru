extends Control

var order
var timer
var time_stop = false

func _ready():
	timer =  get_node("global_timer")
	timer.set_wait_time(0.1)
	timer.start()
	
	order = get_node("order_of_orders")

func _on_global_timer_timeout():
	order.next_action()
	#timer.stop()
