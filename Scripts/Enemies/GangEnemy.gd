extends KinematicBody2D

var missile = preload("res://Scenes/Missiles/EnemyMissiles/EnemyFriendMissile1.tscn")
var missile2 = preload("res://Scenes/Missiles/EnemyMissiles/EnemyMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")
var rng = RandomNumberGenerator.new()
var hp = 3
onready var raycastleft = $RayCastLeft
onready var raycastright = $RayCastRight
var player = false
var velocity = Vector2(0,0)
var speed = 200
var friend = false
var targetfriend 
func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	$ProgressBar.value = hp
	if GameManager.playertank !=null and friend == false:
		if GameManager.playertank !=null:
			look_at(GameManager.playertank.global_position)
		if player == false:
			velocity = GameManager.playertank.global_position - global_position
		else:
			velocity = Vector2.ZERO
	if friend == true:
		look_at(targetfriend.global_position)

	if raycastleft.is_colliding():
		if raycastleft.get_collider() != null:
			if raycastleft.get_collider().is_in_group("GangEnemy"):
				var col = raycastleft.get_collider()
				velocity = col.global_position + global_position
			
	elif raycastright.is_colliding():
		if raycastright.get_collider() !=null:
			if raycastright.get_collider().is_in_group("GangEnemy"):
				var col = raycastright.get_collider()
				velocity = col.global_position + global_position
	move_and_slide(velocity)

func _on_GangEnemyArea_area_entered(area):
	if area.is_in_group("Missile1"):
		take_damage()
	if area.is_in_group("Missile2"):
		hp -=2
		take_damage()
	if area.is_in_group("Missile3"):
		hp -=3
		take_damage()
		
func _on_GangEnemyArea_area_exited(area):
	pass


func shoot():
	var TankSmoke = tanksmoke.instance()
	get_tree().get_root().add_child(TankSmoke)
	TankSmoke.global_position = $ShootPosition.global_position
	if friend == true:
		$AnimatedSprite.play("Fire")
		var Missile = missile.instance()
		get_tree().get_root().add_child(Missile)
		Missile.global_position = $ShootPosition.global_position
		$ShootTimer.start()
	elif player == true:
		$AnimatedSprite.play("Fire")
		var Missile2 = missile2.instance()
		get_tree().get_root().add_child(Missile2)
		Missile2.global_position = $ShootPosition.global_position
		$ShootTimer.start()
func _on_ShootTimer_timeout():
	shoot()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Fire":
		$AnimatedSprite.play("default")



func _on_DetectArea_area_entered(area):
	if area.name == "PlayerArea":
		player = true
		look_at(GameManager.playertank.global_position)
		$ShootTimer.start()
	if area.name == "RadarBoundaryArea" or area.is_in_group("Missile3Radar"):
		if GameManager.targetenemy == null:
			GameManager.targetenemy = self
	if area.is_in_group("Friend"):
		velocity = Vector2(0,0)
		friend_tank()
		targetfriend = area
		friend = true
		print(friend)
		$ShootTimer.start()


func _on_DetectArea_area_exited(area):
	if area.name == "PlayerArea":
		player = false
	if area.is_in_group("Friend"):
		$ShootTimer.start()
		targetfriend = null
		friend = false



func take_damage():
	if hp > 1:
		hp -=1
	else:
		explosion()
func explosion():
	if GameManager.crossenemy == self:
		GameManager.crossenemy = null
	var Explosion = explosion.instance()
	get_tree().get_root().add_child(Explosion)
	Explosion.global_position = global_position

	queue_free()
func friend_tank():
	pass

func gang_position():
	pass



func _on_CrossButton_pressed():
	GameManager.crossenemy = self
	GameManager.playertank.cross_shoot()
