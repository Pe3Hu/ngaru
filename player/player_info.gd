extends Label


var player
var txt

func _ready():
	player = get_node("/root/main/players/"+self.name)
	player.label = self
	update_info()

func update_info():
	txt = "stamina: " + String(player.stamina.current) + "/" + String(player.stamina.max)
	self.text = txt
