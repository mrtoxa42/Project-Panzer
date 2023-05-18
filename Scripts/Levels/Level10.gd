extends Node2D



var moveplayer = preload("res://Scenes/Player/MovePlayer.tscn")


func _ready():
	GameManager.inlevel = true
	GameManager.levelcomplete = false
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 10
	$AnimationPlayer.play("Ani1")
	$CanvasLayer/Particles2D.emitting = true




func game_started():
	var MovePlayer = moveplayer.instance()
	get_tree().get_root().add_child(MovePlayer) 
	MovePlayer.global_position = $Cinematic/PlayerSprite.global_position
	





func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		game_started()
	if anim_name == "GameEndAni":
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func _on_LevelEndTimer_timeout():
	GameManager.game_data.nextlevel = 11
	GameManager.levelcomplete = true
	GameManager.inlevel = false
	$AnimationPlayer.play("GameEndAni")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipAniTimer.start()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
	
