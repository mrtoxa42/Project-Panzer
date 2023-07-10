extends Node2D

onready var player_name = $NameEdit
onready var selected_IP = "192.168.1.112"
onready var selected_port = "4242"


func _ready():
	player_name.text = Save.save_data["Player_name"]
	selected_IP = Server.DEFAULT_IP
	selected_port =Server.DEFAULT_PORT




func _on_NameTextBox_text_changed(new_text):
	Save.save_data["Player_name"] = player_name.text
	Save.save_game()

func _on_PlayGame_pressed():
	Server.selected_IP = selected_IP
	Server.selected_port = int(selected_port)
	Server._connect_to_server()
	$wait.show()
	$WaitTimer.start()




func _on_WaitTimer_timeout():
	Server.load_game()
	queue_free()
