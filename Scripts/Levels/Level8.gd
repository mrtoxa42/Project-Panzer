extends Node2D

var gangfriend = preload("res://Scenes/Player/GangFriend.tscn")
var player = preload("res://Scenes/Player/PlayerTank.tscn")
var currentenemy = 11


func _ready():
	GameManager.inlevel = true
	GameManager.levelcomplete = false
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 8
	$AnimationPlayer.play("Ani1")
	$CanvasLayer/CurrentEnemyLabel.hide()





func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
	if anim_name == "Ani2":
		$AnimationPlayer.play("Ani3")
	if anim_name == "Ani3":
		game_started()
	if anim_name == "EndCinematic":
		$CanvasLayer/CurrentEnemyLabel.hide()
		game_end()
		



func game_started():
	$CanvasLayer/CurrentEnemyLabel.show()
	$CanvasLayer/CurrentEnemyLabel.text = "KALAN DÜŞMAN SAYISI: " + str(currentenemy)
	var Friend1 = gangfriend.instance()
	get_tree().get_root().add_child(Friend1)
	Friend1.global_position = $Cinematic3/Friend1.global_position
	var Friend2 = gangfriend.instance()
	get_tree().get_root().add_child(Friend2)
	Friend2.global_position = $Cinematic3/Friend2.global_position
	var Friend3 = gangfriend.instance()
	get_tree().get_root().add_child(Friend3)
	Friend3.global_position = $Cinematic3/Friend3.global_position
	var Player = player.instance()
	get_tree().get_root().add_child(Player)
	Player.global_position = $Cinematic3/PlayerSprite.global_position
	$Cinematic3.queue_free()
	var Friend4 = gangfriend.instance()
	get_tree().get_root().add_child(Friend4)
	Friend4.global_position = $Cinematic3/Friend4.global_position
	var Friend5 = gangfriend.instance()
	get_tree().get_root().add_child(Friend5)
	Friend5.global_position = $Cinematic3/Friend5.global_position
	


func death_enemy():
	if currentenemy > 1:
		currentenemy -=1
		$CanvasLayer/CurrentEnemyLabel.text = "KALAN DÜŞMAN SAYISI: " + str(currentenemy)
		
	else:
		GameManager.game_data.nextlevel = 9
		GameManager.levelcomplete = true
		GameManager.inlevel = false
		$AnimationPlayer.play("EndCinematic")
		

func game_end():
	get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipAniTimer.start()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 64
