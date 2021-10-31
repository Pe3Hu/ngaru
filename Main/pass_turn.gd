extends CheckButton

func _on_pass_turn_pressed():
	var order = get_node("/root/main/order_of_moves")
	var player_name = get_parent().get_parent().get_parent().name
	
	if order.current_action[player_name]:		
		order.jot_pass(player_name)
		disabled = true
		get_parent().get_node("add_to_blank").visible = false
		
		if order.current["passed_player"] == null:
			order.current["passed_player"] = player_name
		else:
			order.end_round_check()
	else:
		pressed = false
