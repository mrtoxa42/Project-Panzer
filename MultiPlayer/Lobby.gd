extends Control


onready var  player_name = $CenterContainer/VBoxContainer/GridContainer/NameTextBox
onready var selected_IP = $CenterContainer/VBoxContainer/GridContainer/IPTextBox
onready var selected_port = $CenterContainer/VBoxContainer/GridContainer/PortTextBox

func _ready():
	player_name.text = MultiPlayerSave.save_data["Player_name"]
	selected_IP.text = Server.DEFAULT_IP
	selected_port.text = str(Server.DEFAULT_PORT)

func _on_JoinBtn_pressed():
	Server.selected_IP = selected_IP.text
	Server.selected_port = int(selected_port.text)
	Server._connect_to_server()


func _on_NameTextBox_text_changed(new_text):
	MultiPlayerSave.save_data["Player_name"] = player_name.text
	MultiPlayerSave.save_game()
	 
