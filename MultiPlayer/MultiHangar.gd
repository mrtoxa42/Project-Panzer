extends Node2D



func _on_PlayButton_pressed():
#	Client._connect_to_server()
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
