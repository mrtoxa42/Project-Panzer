extends Node2D


var player = preload("res://Scenes/Player/PlayerTank.tscn")

func _ready():
	GameManager.inlevel = true
	GameManager.levelcomplete = false
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 11
	$Particles2D2.emitting = true
	$AnimationPlayer.play("Ani1")


	


func game_started():
	var Player = player.instance()
	get_tree().get_root().add_child(Player)
	Player.global_position = $Cinematic/PlayerSprite.global_position
	$Cinematic.hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		game_started()
	if anim_name =="EndAni":
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
func game_end():
	GameManager.game_data.nextlevel = 12
	GameManager.levelcomplete = true
	GameManager.inlevel = false
	$AnimationPlayer.play("EndAni")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipAniTimer.start()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
