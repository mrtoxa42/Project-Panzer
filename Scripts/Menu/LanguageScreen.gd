extends Node2D


func _ready():
	GameManager.game_data.firstopen = false

func _on_Turkiye_pressed():
	GameManager.game_data.Language = "Turkish"
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
func _on_English_pressed():
	GameManager.game_data.Language = "English"
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
func _on_Russian_pressed():
	GameManager.game_data.Language = "Russian"
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
