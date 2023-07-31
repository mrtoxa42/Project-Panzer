extends Node2D


var player = preload("res://Scenes/Player/PlayerTank.tscn")

func _ready():
	if GameManager.game_data.Language == "Turkish":
		$Cinematic3/OrgLabel.show()
		$Cinematic3/OrgLabel2.hide()
		$Cinematic3/OrgLabel3.hide()
	elif GameManager.game_data.Language == "English":
		$Cinematic3/OrgLabel.hide()
		$Cinematic3/OrgLabel2.show()
		$Cinematic3/OrgLabel3.hide()
	elif GameManager.game_data.Language == "Russian":
		$Cinematic2/OrgLabel.hide()
		$Cinematic2/OrgLabel2.hide()
		$Cinematic2/OrgLabel3.show()
	$AnimationPlayer.play("Ani1")
	$CanvasLayer/Particles2D.emitting = true
	GameManager.inlevel = true
	GameManager.playedlevel = self
	GameManager.level4move = false
	GameManager.CurrentLevel = 4


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
	if anim_name == "Ani2":
		var Player = player.instance() 
		get_tree().get_root().add_child(Player)
		Player.global_position = $Cinematic2/TankSprite.global_position
		$Cinematic2.hide()
		$Cinematic2/DialogueBox.hide()
		GameManager.level4move = true
	if anim_name == "ExplosionAni":
		$AnimationPlayer.play("EndAni")
	if anim_name == "EndAni":
		GameManager.levelcomplete = true
		var r = get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func _on_LevelFinished_area_entered(area):
	if area.name == "PlayerArea":
		$AnimationPlayer.play("ExplosionAni")
		GameManager.inlevel = false
		GameManager.game_data.nextlevel = 5
	


func _on_SkinAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipAniTimer.start()
	GameManager.level4move = true


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
	
