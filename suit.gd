extends Node2D


var connects
var core

func set_connects(_value):
	connects.frame = 0
	core.frame = 0
	
func _ready():
	connects = get_node("connects")
	core = get_node("core")
