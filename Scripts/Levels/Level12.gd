extends Node2D

var player = preload("res://Scenes/Player/PlayerTank.tscn")
func _ready():
	$AnimationPlayer.play("Ani1")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
		if $AnimationPlayer.playback_speed == 1:
			$Cinematic2/VideoPlayer.play()
		else:
			$AnimationPlayer.play("Ani3")
	if anim_name == "Ani3":
		$AnimationPlayer.play("Ani4")
	if anim_name == "Ani4":
		get_tree().change_scene("res://Scenes/Levels/BossScenes/BossFight.tscn")


func _on_VideoPlayer_finished():
	$AnimationPlayer.play("Ani3")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	if $Cinematic2/VideoPlayer != null:
		$Cinematic2/VideoPlayer.queue_free()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
