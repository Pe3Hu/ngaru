extends Node

signal max_value_changed(new_max)
signal current_value_changed(new_current)
signal depleted

export(int) var max_value = 10 setget set_max
onready var current_value = max_value setget set_current

func _ready():
	_initialize()

func set_max(new_max):
	max_value = new_max
	max_value = max(1, new_max)
	emit_signal("max_value_changed", max_value)
	
func set_current(new_current):
	current_value = new_current
	current_value = clamp(current_value, 0, max_value)
	emit_signal("current_value_changed", current_value)
	
	if current_value == 0:
		emit_signal("depleted")	

func _initialize():
	emit_signal("max_value_changed", max_value)
	emit_signal("current_value_changed", current_value)
