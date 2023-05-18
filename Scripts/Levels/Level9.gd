extends Node2D


var player = preload("res://Scenes/Player/PlayerTank.tscn")
var friend = preload("res://Scenes/Player/GangFriend.tscn")
var currentfriend = 4 
var cine3 = false


func _ready():
	GameManager.inlevel = true
	GameManager.levelcomplete = false
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 9
	$AnimationPlayer.play("Ani1")




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
	if anim_name == "Ani2":
		cine3 = true
		$Cinematic3/PathTimer.start()
		$AnimationPlayer.play("Ani3")
	if anim_name == "Ani3":
		cine3 = false
		$AnimationPlayer.play("Ani4")
	if anim_name == "Ani4":
		$Cinematic4.hide()
		game_started()
	if anim_name == "EndAni":
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
func game_started():
	var Player = player.instance()
	get_tree().get_root().add_child(Player)
	Player.global_position = $Cinematic/PlayerSprite.global_position
	
	var Friend1 = friend.instance()
	get_tree().get_root().add_child(Friend1)
	Friend1.global_position = $Cinematic4/Friend1.global_position
	var Friend2 = friend.instance()
	get_tree().get_root().add_child(Friend2)
	Friend2.global_position = $Cinematic4/Friend2.global_position
	var Friend3 = friend.instance()
	get_tree().get_root().add_child(Friend3)
	Friend3.global_position = $Cinematic4/Friend3.global_position
	var Friend4 = friend.instance()
	get_tree().get_root().add_child(Friend4)
	Friend4.global_position = $Cinematic4/Friend4.global_position


func draw_path():
	pass



func _on_PathTimer_timeout():
	if cine3 == true:
		var a = Sprite.new()
		a.texture = load("res://Assets/Extras/PathTry.png")
		$Cinematic3/PathSpawn.add_child(a)
		a.modulate.a = 0.7
		a.global_position = Vector2($Cinematic3/Us.global_position - Vector2(20,20))
		$Cinematic3/PathTimer.start()

func death_friend():
	if currentfriend > 1:
		currentfriend-=1
	else:
		game_end()

func game_end():
	GameManager.game_data.nextlevel = 10
	GameManager.levelcomplete = true
	GameManager.inlevel = false
	$AnimationPlayer.play("EndAni")


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer/SkipAniTimer.start()


func _on_SkipAniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
	
