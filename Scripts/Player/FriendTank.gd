extends KinematicBody2D


var hp =20
var damage = 1
var enemy = false
var targetenemy = null
var playerarea = false


var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/FriendMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")

func _process(delta):
	if targetenemy != null:
		look_at(targetenemy.global_position)
	if GameManager.inlevel == false:
		queue_free()
	$ProgressBar.value = hp




func _on_DetectArea_area_entered(area):
	if area.is_in_group("Enemy"):
		if targetenemy == null:
			targetenemy = area
			enemy = true
			$ShootTimer.start()



func _on_DetectArea_area_exited(area):
	if area.is_in_group("Enemy"):
		if targetenemy == area:
			enemy = false
			targetenemy = null
		

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
