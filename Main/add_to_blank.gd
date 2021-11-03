extends Button

func _on_add_to_blank_pressed():
	var order = get_node("/root/main/order_of_orders")
	var player_name = get_parent().get_parent().get_parent().name
	
	if order.current_action[player_name]:	
		var preparation_hbox = get_node("/root/main/bg/rows/tabs/preparation/grid/"+player_name)
		var player = get_node("/root/main/players/"+player_name)
		var vials_slider = preparation_hbox.get_node("vials/cols/slider")
		var stencils_slider = preparation_hbox.get_node("stencils/cols/slider")
		var blanks_slider = preparation_hbox.get_node("blanks/rows/cols/slider")
		
		if	(vials_slider.max_value != -1 &&
			stencils_slider.max_value != -1 &&
			blanks_slider.max_value != -1 ):	
			if player.stamina["current"] > player.current["stamina_price"]:			
				var vial = player.get_node("vials").current_hand[vials_slider.value]
				var stencil = player.get_node("stencils").current_hand[stencils_slider.value]
				var blank = player.get_node("blanks").current_hand[blanks_slider.value]
				
				blank.add_to_charge(vial, stencil)
				order.jot_add(player, vial, stencil, blank)
				
				vial.set_visible(false)
				player.get_node("vials").discard_deck.append(vial)
				player.get_node("vials").current_hand.remove(vials_slider.value)
				vials_slider.max_value = player.get_node("vials").current_hand.size() - 1
				
				stencil.set_visible(false)
				player.get_node("stencils").discard_deck.append(stencil)
				player.get_node("stencils").current_hand.remove(stencils_slider.value)
				stencils_slider.max_value = player.get_node("stencils").current_hand.size() - 1
				
				player.stamina["current"] -= player.current["stamina_price"]
				player.current["counter"] += 1
				player.current["stamina_price"] = pow(player.current["counter"],2)	
				player.label.update_info()
					
				if stencils_slider.max_value == -1:
					stencils_slider.visible = false
				else:
					player.select_by_priority()
