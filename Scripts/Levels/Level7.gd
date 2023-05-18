extends Node2D

var player = preload("res://Scenes/Player/PlayerTank.tscn")
var enemy1 = preload("res://Scenes/Enemies/MoveEnemy.tscn")
var friend = preload("res://Scenes/Player/FriendMoveTank.tscn")
var spawnnumber = 0
var jailarea = false
var jailmission = false

func _ready():
	GameManager.inlevel = true
	GameManager.levelcomplete = false
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 7
	$AnimationPlayer.play("Ani1")
	
	$GeneralTank.hide()

	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
	if anim_name == "Ani2":
		$AnimationPlayer.play("Ani3")
	if anim_name == "Ani3":
		$AnimationPlayer.play("Ani4")
		$Cinematic3.hide()
		$Cinematic2.hide()
		$Cinematic.hide()
	if anim_name == "Ani4":
		$AnimationPlayer.play("Ani5")
	if anim_name == "Ani5":
		$GeneralTank.show()
		$AnimationPlayer.play("Ani6")
	if anim_name == "Ani6":
		$Fence1.queue_free()
		game_started()
	if anim_name == "JailAni":
		$CinematicJail/JailCamera.queue_free()
		GameManager.playertank.current_camera()
	if anim_name == "GameEnd":
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func game_started():
	var Player = player.instance()
	get_tree().get_root().add_child(Player)
	Player.global_position = $Cinematic5/PlayerSprite.global_position
	$Cinematic4.hide()
	$Cinematic5.hide()
	$Cinematic6.hide()


func _on_JailArea_area_entered(area):
	if area.name == "PlayerArea":
		if jailarea == false:
			$AnimationPlayer.play("JailAni")
			jailarea = true


func _on_JailEverArea_area_entered(area):
	if area.name == "PlayerArea":
		if  jailarea == true:
			$JailLever/JailEverButton.show()
		


func _on_JailEverArea_area_exited(area):
	if area.name == "PlayerArea":
		if jailarea == true:
			$JailLever/JailEverButton.hide() 
		
		

func _on_JailEverButton_pressed():
	jailmission = true
	var Friend1 = friend.instance()
	var Friend2 = friend.instance()
	get_tree().get_root().add_child(Friend1)
	get_tree().get_root().add_child(Friend2)
	Friend1.global_position = $CinematicJail/Friend1.global_position
	Friend2.global_position = $CinematicJail/Friend2.global_position
	$CinematicJail.hide()
	$Jail.queue_free()


func _on_LevelEndArea_area_entered(area):
	if area.name == "PlayerArea":
		if jailmission == false:
			$LevelEndCinematicFalse.show()
		elif jailmission == true:
			game_end()

func _on_LevelEndArea_area_exited(area):
	if jailmission == false:
		$CanvasLayer/LevelEndCinematicFalse.hide()
func game_end():
	GameManager.game_data.nextlevel = 8
	GameManager.levelcomplete = true
	GameManager.inlevel = false
	$AnimationPlayer.play("GameEnd")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipAniTimer.start()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
	
