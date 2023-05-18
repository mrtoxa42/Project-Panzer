extends CanvasLayer

func game_paused():
	if get_tree().paused == false:
		get_tree().paused = true
		$MenuPause.show()
	else:
		get_tree().paused = false
		$MenuPause.hide()


func _on_PauseButton_pressed():
	game_paused()


func _on_ContinueButton_pressed():
	game_paused()
	


func _on_RestartButton_pressed():
	get_tree().paused = false
	$MenuPause.hide()
	if GameManager.playertank !=null:
		GameManager.playertank.delete_player()
	get_tree().change_scene("res://Scenes/Levels/Level"+ str(GameManager.CurrentLevel) + ".tscn")


func _on_HangarButton_pressed():
	get_tree().paused = false
	if GameManager.playertank != null:
		GameManager.playertank.delete_player()
	get_tree().change_scene("res://Scenes/Game/Hangar.tscn")
	
