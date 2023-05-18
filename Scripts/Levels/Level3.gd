extends Node2D

var player = preload("res://Scenes/Player/PlayerTank.tscn")

func _ready():
	if GameManager.game_data.Language == "Turkish":
		$Cinematic2/OrgLabel.show()
		$Cinematic2/OrgLabel2.hide()
		$Cinematic2/OrgLabel3.hide()
	elif GameManager.game_data.Language == "English":
		$Cinematic2/OrgLabel.hide()
		$Cinematic2/OrgLabel2.show()
		$Cinematic2/OrgLabel3.hide()
	elif GameManager.game_data.Language == "Russian":
		$Cinematic2/OrgLabel.hide()
		$Cinematic2/OrgLabel2.hide()
		$Cinematic2/OrgLabel3.show()
	$AnimationPlayer.play("Ani1")
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 3
	GameManager.inlevel = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$Camera.current = false
		var Player = player.instance()
		get_tree().get_root().add_child(Player)
		Player.global_position = $Cinematic/PlayerTank.global_position
		$AnimationPlayer.play("Ani2")
	if anim_name == "EndAni":
		GameManager.levelcomplete = true
		GameManager.game_data.nextlevel = 4
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")


func _on_EndAreaLevel3_area_entered(area):
	if area.name == "PlayerArea":
		print("PlayerGirdi")
		GameManager.inlevel = false
		$AnimationPlayer.play("EndAni")


func _on_AniSkipButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/AniSkipTimer.start()


func _on_AniSkipTimer_timeout():
	$AnimationPlayer.playback_speed = 1
