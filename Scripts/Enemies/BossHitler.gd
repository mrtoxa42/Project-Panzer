extends KinematicBody2D


var speed = 20
var velocity = Vector2.ZERO
var YahudiEnemy = true
var direction = ""
var gameend = "Good"
var faze = 1
var missile1 = preload("res://Scenes/Missiles/EnemyMissiles/BossMissile/BossMissile1.tscn")
var missile2 = preload("res://Scenes/Missiles/EnemyMissiles/BossMissile/BossMissile2.tscn")
var missile22 = preload("res://Scenes/Missiles/EnemyMissiles/BossMissile/BossMissile22.tscn")
var Direct22 = "Right"
var movement = false
var hp = 100
var rng = RandomNumberGenerator.new()





func _ready():
	GameManager.bosshitler = self

func _process(delta):
	if faze == 1 or faze == 2 or faze == 3:
		if direction == "Right":
			if position.x <= 1000:
				velocity.x = speed * delta
			else:
				direction = "Left"
		if direction == "Left":
			if position.x >= 70:
				velocity.x = -speed * delta
			else:
				direction = "Right"
	else:
		velocity.x = 0
	move_and_collide(velocity * speed)

#
#
#
func _on_MoveTimer_timeout():
	if faze == 1 or faze == 3:
		rng.randomize()
		var r = rng.randi_range(0,1)
		if r == 0:
			direction = "Right"
		elif r == 1:
			direction = "Left"
	if faze == 2:
		if movement == false:
			rng.randomize()
			var r = rng.randi_range(0,1)
			if r == 0:
				direction = "Right"
			elif r == 1:
				direction = "Left"
		else:
			direction = ""
			velocity.x = 0
			$ShootTimer.start()


func play_fight():
	$MoveTimer.start()
	$ShootTimer.start()





func _on_BossHitlerArea_area_entered(area):
	if area.is_in_group("BossPlayerMissile"):
		hp -= 10
		if hp == 70:
			faze = 2
			$MoveTimer.wait_time = 3
			$Faze2Timer.start()
			$ShootTimer.wait_time = 0.3
			movement = true
		if hp == 30:
			faze = 3


func _on_ShootTimer_timeout():
	if faze == 1 or faze == 3:
		$ShootTimer.start()
		var Missile1 = missile1.instance()
		get_tree().get_root().add_child(Missile1)
		Missile1.global_position = $ShootPosition.global_position
	if faze == 2:
		var Missile2 = missile2.instance()
		get_tree().get_root().add_child(Missile2)
		Missile2.global_position = $ShootPosition.global_position
		var Missile22 = missile22.instance()
		get_tree().get_root().add_child(Missile22)
		Missile22.global_position = $ShootPosition.global_position
		
	
		


func _on_Faze2Timer_timeout():
	if movement == true:
		movement = false
		$ShootTimer.stop()
	else:
		movement = true

	$MoveTimer.start()

