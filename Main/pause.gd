extends CheckButton


func _on_game_pause_pressed():
	var timer = get_node("/root/main/global_timer")
	if timer.is_stopped():
		timer.start()
	else:
		timer.stop()
