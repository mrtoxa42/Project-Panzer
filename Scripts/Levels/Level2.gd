extends Node2D

var levelprocess = true
var stationhp = 100
var player = preload("res://Scenes/Player/PlayerTank.tscn")
var medal1 = preload("res://Scenes/Extras/Enrivorment&Pull/GatherMedal.tscn")
var staticenemy = preload("res://Scenes/Enemies/StaticEnemy.tscn")
var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
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
	GameManager.level2station = $StationArea
	$AnimationPlayer.play("Ani1")
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 2
	GameManager.inlevel = true

func _process(delta):
	$CanvasLayer/StationHealth.value = stationhp
	
	if stationhp <= 0:
		GameManager.levelcomplete = false
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		var Player = player.instance()
		get_tree().get_root().add_child(Player)
		Player.global_position = $TankPlayer.global_position
		$TankPlayer.hide()
		$EnemySpawnTimer.start()
	if anim_name =="EndAni":
		GameManager.player_data.Medal2 += 1
		GameManager.game_data.nextlevel = 3
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
		
		

func _on_EnemySpawnTimer_timeout():
	rng.randomize()
	var r = rng.randi_range(100,750)
	$EnemySpawner.position.y = r
	var StaticEnemy = staticenemy.instance()
	get_tree().get_root().add_child(StaticEnemy)
	StaticEnemy.global_position = $EnemySpawner.global_position
	if levelprocess == true:
		$EnemySpawnTimer.start()
	


func _on_LevelEndTimer_timeout():
	levelprocess = false
	GameManager.playertank.delete_player()
	GameManager.levelcomplete = true
	GameManager.gathermedal2 = true
	GameManager.inlevel = false
	$AnimationPlayer.play("EndAni")
	
	

func _on_MedalTimer_timeout():
	rng2.randomize()
	var r2 = rng2.randi_range(142,542)
	$MedalTimer/Position2D.position.y = r2
	var Medal1 = medal1.instance()
	get_tree().get_root().add_child(Medal1)
	Medal1.global_position = $MedalTimer/Position2D.global_position


func _on_AniSkipButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/AniSkipTimer.start()


func _on_AniSkipTimer_timeout():
	$AnimationPlayer.playback_speed = 1


func _on_StationArea_area_entered(area):
	if area.is_in_group("EnemyMissile"):
		if levelprocess == true:
			stationhp -= 5
