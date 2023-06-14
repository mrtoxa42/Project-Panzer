extends Control


onready var  player_name = $CenterContainer/VBoxContainer/GridContainer/NameTextBox
onready var selected_IP = $CenterContainer/VBoxContainer/GridContainer/IPTextBox
onready var selected_port = $CenterContainer/VBoxContainer/GridContainer/PortTextBox
onready var waitingroom = $WaitingRoom
onready var ready_btn =  $WaitingRoom/CenterContainer/VBoxContainer/Ready
func _ready():
	player_name.text = MultiPlayerSave.save_data["Player_name"]
	selected_IP.text = Server.DEFAULT_IP
	selected_port.text = str(Server.DEFAULT_PORT)
func _on_JoinBtn_pressed():
	Server.selected_IP = selected_IP.text
	Server.selected_port = int(selected_port.text)
	Server._connect_to_server()
	show_waiting_room()

func _on_NameTextBox_text_changed(new_text):
	MultiPlayerSave.save_data["Player_name"] = player_name.text
	MultiPlayerSave.save_game()
	 
func show_waiting_room():
	waitingroom.popup_centered()

func _on_Ready_pressed():
	ready_btn.disabled = true
	Server.load_game()
	Input.vibrate_handheld(500)
