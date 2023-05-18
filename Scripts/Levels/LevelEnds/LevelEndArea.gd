extends Area2D


func _ready():
	GameManager.levelend = global_position


func _on_Level1EndArea_area_entered(area):
	if area.name == "PlayerArea":
		GameManager.levelcomplete = true
		GameManager.inlevel = false
#		print("a")
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
		if GameManager.game_data.nextlevel == 1:
			GameManager.game_data.nextlevel = 2
		elif GameManager.game_data.nextlevel == 2:
			GameManager.game_data.nextlevel = 3
		elif GameManager.game_data.nextlevel == 3:
			GameManager.game_data.nextlevel = 4
		elif GameManager.game_data.nextlevel == 4:
			GameManager.game_data.nextlevel = 5
		elif GameManager.game_data.nextlevel == 5:
			GameManager.game_data.nextlevel = 6
		elif GameManager.game_data.nextlevel == 6:
			GameManager.game_data.nextlevel = 7
		elif GameManager.game_data.nextlevel == 7:
			GameManager.game_data.nextlevel = 8
		elif GameManager.game_data.nextlevel == 8:
			GameManager.game_data.nextlevel = 9
		elif GameManager.game_data.nextlevel == 9:
			GameManager.game_data.nextlevel = 10
		elif GameManager.game_data.nextlevel == 10:
			GameManager.game_data.nextlevel = 11
		elif GameManager.game_data.nextlevel == 11:
			GameManager.game_data.nextlevel = 12
		
