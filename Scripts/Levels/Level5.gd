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
	GameManager.inlevel = true
	GameManager.CurrentLevel = 5
	GameManager.playedlevel = self
	$AnimationPlayer.play("Ani1")
	
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		var Player = player.instance()
		get_tree().get_root().add_child(Player)
		Player.global_position = $Cinematic2/Sprite.global_position
		Player.rotation_degrees = 180
		$Cinematic2.hide()


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer/SkipAniTimer.start()
	


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
