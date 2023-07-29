extends Control

onready var player_name = $NameTextBox
onready var selected_IP = "192.168.1.112"
onready var selected_port = 3234


func _ready():
	player_name.text = Save.save_data["Player_name"]
	selected_IP = Server.DEFAULT_IP
	selected_port = str(Server.DEFAULT_PORT)


func _on_JoinBtn_pressed():
		Server.selected_IP = selected_IP
		Server.selected_port = int(selected_port)
		Server._connect_to_server()
		$Timer.start()
		$CanvasLayer.show()
		$CanvasLayer/AnimatedSprite.play("default")




func _on_NameTextBox_text_changed(new_text):
	Save.save_data["Player_name"] = player_name.text
	Save.save_game()
	






func _on_Timer_timeout():
	Server.load_game()
