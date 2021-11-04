extends Button


func _on_activate_blank_pressed():	
	var order = get_node("/root/main/order_of_orders")
	var player_name = get_parent().get_parent().get_parent().name
	
	if order.current_action[player_name]:
		var player = get_node("/root/main/players/"+player_name)
		var preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+player_name)
		var blanks_slider = preparation_hbox.get_node("blanks/rows/cols/slider")
		var blank = player.get_node("blanks").current_hand[blanks_slider.value]
		var impact = get_node("/root/main/bg/rows/tabs/impact")
		
		if order.current["onslaught_player"] == null:
			order.current["onslaught_player"] = player_name
			impact.get_node("players/onslaught").set_values(blank,player_name)
		else:
			impact.get_node("players/retention").set_values(blank,player_name)
		
		order.jot_activate(player, blank)
		blank.clean()
		get_parent().get_node("pass_turn").disabled = true
		get_parent().get_node("add_to_blank").visible = false
		visible = false
		order.impact_flag = true
