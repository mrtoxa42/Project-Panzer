extends KinematicBody2D


var hp =20
var damage = 1
var enemy = false
var targetenemy = null
var playerarea = false
var movetimer = false
var bush = false

var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/FriendMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")
var movesmoke = preload("res://Scenes/Extras/MoveSmoke.tscn")

func _process(delta):
	if targetenemy != null:
		look_at(targetenemy.global_position)
	if GameManager.inlevel == false:
		queue_free()
	if playerarea == false:
		if GameManager.playertank != null:
			var velocity = GameManager.playertank.global_position - global_position
			velocity = move_and_slide(velocity)
	if playerarea == true and GameManager.playertank != null and targetenemy == null:
		look_at(GameManager.playertank.global_position)
	$ProgressBar.value = hp




func _on_DetectArea_area_entered(area):
	if area.is_in_group("Enemy"):
		if targetenemy == null:
			targetenemy = area
			enemy = true
			$ShootTimer.start()
	if area.name == "PlayerArea":
		$MoveTimer.start()



func _on_DetectArea_area_exited(area):
	if area.is_in_group("Enemy"):
		if targetenemy == area:
			enemy = false
			targetenemy = null
		
	if area.name == "PlayerArea":
		playerarea = false
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
	if area.is_in_group("MoveEnemy"):
		if bush == false:
			GameManager.levelcomplete = false
			GameManager.inlevel = false
			get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func _on_MoveSmokeTimer_timeout():
	if playerarea == false:
		var MoveSmoke = movesmoke.instance()
		get_tree().get_root().add_child(MoveSmoke)
		MoveSmoke.global_position = $Egzoz.global_position


func _on_MoveTimer_timeout():
	playerarea = true


func _on_FriendBushArea_area_entered(area):
	if area.is_in_group("Bush"):
		bush()



func _on_FriendBushArea_area_exited(area):
	if area.is_in_group("Bush"):
		exit_bush()
		
func bush():
	modulate.a = 0.4
	bush = true
func exit_bush():
	modulate.a = 1
	bush = false

