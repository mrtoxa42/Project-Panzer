extends KinematicBody2D


var hp =20
var damage = 1
var speed = 200
var enemy = false
var targetenemy = null
var playerarea = false
var direction = ""
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/FriendMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")

func _process(delta):
	if targetenemy != null:
		look_at(targetenemy.global_position)
	if GameManager.inlevel == false:
		queue_free()
	$ProgressBar.value = hp
	if direction == "Right":
		if global_position.x < 5620:
			rotation_degrees = 90
			position.x += speed * delta
	elif direction == "Left":
		if global_position.x > 1 :
			rotation_degrees = -90
			position.x -= speed * delta
	elif direction == "Up":
		if global_position.y > 1:
			rotation_degrees = 0
			position.y -= speed * delta
	elif direction == "Down":
		if global_position.y <2850:
			rotation_degrees = 180
			position.y += speed * delta



func _on_DetectArea_area_entered(area):
	if area.is_in_group("Enemy"):
		if targetenemy == null:
			targetenemy = area
			enemy = true
			direction = ""
			$AnimationPlayer.play("Shoot")
			$ShootTimer.start()



func _on_DetectArea_area_exited(area):
	if area.is_in_group("Enemy"):
		if targetenemy == area:
			enemy = false
			targetenemy = null
			$AnimationPlayer.play("Move")
			$AnimationPlayer2.play("Detect")
		

func shoot():
	if enemy == true:
		var Missile1 = missile1.instance()
		get_tree().get_root().add_child(Missile1)
		$AnimatedSprite.play("Fire")
		Missile1.global_position = $ShootPosition.global_position
		var Smoke = tanksmoke.instance()
		get_tree().get_root().add_child(Smoke)
		Smoke.global_position = $ShootPosition.global_position
		$ShootTimer.start()
	


func _on_ShootTimer_timeout():
	shoot()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Fire":
		$AnimatedSprite.play("default")



func take_damage():
	if hp > 1:
		hp -=1
	else:
		_explosion()

func _explosion():
	var Explosion = explosion.instance()
	get_tree().get_root().add_child(Explosion)
	Explosion.global_position = global_position
	queue_free()
	


func _on_FriendArea_area_entered(area):
	if area.is_in_group("EnemyMissile"):
		take_damage()






func _on_RandomMoveTimer_timeout():
	if targetenemy == null:
		$RandomMoveTimer.wait_time = 3
		rng.randomize()
		var r = rng.randi_range(0,3)
		if r == 0:
			direction = "Right"
		elif r == 1:
			direction = "Left"
		elif r ==2:
			direction = "Up"
		elif r ==3:
			direction = "Down"
	else:
		direction = ""
