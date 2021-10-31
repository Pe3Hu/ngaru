extends Label


var player
var txt

func _ready():
	player = get_node("/root/main/players/"+self.name)
	update_info()

func update_info():
	txt = "energy: " + String(player.energy.current) + "/" + String(player.energy.max)
	self.text = txt
