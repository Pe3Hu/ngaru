extends Button

func _on_add_to_blank_pressed():
	var hbox = get_parent().get_parent().get_parent()
	var player = hbox.get_node("player")
	var vials_slider = hbox.get_node("vials/cols/slider")
	var stencils_slider = hbox.get_node("stencils/cols/slider")
	var blanks_slider = hbox.get_node("blanks/rows/cols/slider")
	if	(vials_slider.max_value != -1 &&
		stencils_slider.max_value != -1 &&
		blanks_slider.max_value != -1 ):
		var vial = player.get_node("vials").current_hand[vials_slider.value]
		var stencil = player.get_node("stencils").current_hand[stencils_slider.value]
		var blank = player.get_node("blanks").current_hand[blanks_slider.value]
		
		blank.add_to_charge(vial, stencil)
		
		vial.set_visible(false)
		player.get_node("vials").current_hand.remove(vials_slider.value)
		vials_slider.max_value = player.get_node("vials").current_hand.size() - 1
		
		stencil.set_visible(false)
		player.get_node("stencils").current_hand.remove(stencils_slider.value)
		stencils_slider.max_value = player.get_node("stencils").current_hand.size() - 1
		if stencils_slider.max_value == -1:
			stencils_slider.visible = false
		else:	
			player.select_by_priority()
