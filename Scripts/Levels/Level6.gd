extends Node2D

var player = preload("res://Scenes/Player/PlayerTank.tscn")
var medal1 = preload("res://Scenes/Extras/Enrivorment&Pull/GatherMedal.tscn")
var medalnumber = 0
var spawnx = 0
var spawny = 0
var rngx = RandomNumberGenerator.new()
var rngy  = RandomNumberGenerator.new()


func _ready():
	GameManager.inlevel = true
	GameManager.CurrentLevel = 6
	GameManager.playedlevel = self
	if GameManager.game_data.Language == "Turkish":
		$Cinematic/OrgLabel.show()
		$Cinematic/OrgLabel2.hide()
		$Cinematic/OrgLabel3.hide()
		$Cinematic3/OrgLabel.show()
		$Cinematic3/OrgLabel2.hide()
		$Cinematic3/OrgLabel3.hide()
	elif GameManager.game_data.Language == "English":
		$Cinematic/OrgLabel.hide()
		$Cinematic/OrgLabel2.show()
		$Cinematic/OrgLabel3.hide()
		$Cinematic3/OrgLabel.hide()
		$Cinematic3/OrgLabel2.show()
		$Cinematic3/OrgLabel3.hide()

	elif GameManager.game_data.Language == "Russian":
		$Cinematic/OrgLabel.hide()
		$Cinematic/OrgLabel2.hide()
		$Cinematic/OrgLabel3.show()
		$Cinematic3/OrgLabel.hide()
		$Cinematic3/OrgLabel2.hide()
		$Cinematic3/OrgLabel3.show()
	$AnimationPlayer.play("Ani1")


func _process(delta):
#	print("Merhaba Adb")
	pass
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")
	if anim_name == "Ani2":
		$AnimationPlayer.play("Ani3")
	if anim_name == "Ani3":
		play_game()
	if anim_name == "GameEnd":
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func play_game():
	$LevelEndTimer.start()
	var Player = player.instance()
	get_tree().get_root().add_child(Player)
	Player.global_position = $PlayerTank.global_position
	$PlayerTank.hide()


func _on_MedalTimer_timeout():
	if GameManager.playertank != null and medalnumber <3:
		$MedalTimer/Position2D.global_position = GameManager.playertank.global_position - Vector2(200,200)
		var Medal1 = medal1.instance()
		get_tree().get_root().add_child(Medal1)
		Medal1.global_position = $MedalTimer/Position2D.global_position
		medalnumber +=1


func _on_LevelEndTimer_timeout():
	game_end()
	
func game_end():
	GameManager.game_data.nextlevel = 7
	GameManager.levelcomplete = true
	GameManager.inlevel = false
	$AnimationPlayer.play("GameEnd")


func _on_SpawnPositionTimer_timeout():
	rngx.randomize()
	rngy.randomize()
	spawnx = rngx.randi_range(0,300)
	spawny = rngy.randi_range(0,300)
	$GangEnemySpawner.position.x += spawnx
	$GangEnemySpawner.position.y += spawny


func _on_SkipAniButton_pressed():
	$AnimationPlayer.playback_speed = 64
	$CanvasLayer2/SkipaniTimer.start()
	


func _on_SkipaniTimer_timeout():
	$AnimationPlayer.playback_speed = 1
