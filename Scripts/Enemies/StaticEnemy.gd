extends Area2D


var speed = 200
var missile1 = preload("res://Scenes/Missiles/EnemyMissiles/StaticEnemyMissile.tscn")
var move = false
var hp = 3
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")

func _ready():
	if GameManager.CurrentLevel ==2:
		move = true
		$Movetimer.start()


func _process(delta):
	$HpBar.value = hp
	if GameManager.inlevel == false:
		queue_free()
	if move == true:
		position.x -= speed * delta


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Fire":
		$AnimatedSprite.play("default")




func _on_AttackTimer_timeout():
	$AnimatedSprite.play("Fire")
	var Missile1 = missile1.instance()
	get_tree().get_root().add_child(Missile1)
	Missile1.global_position = $Position2D.global_position
	$AttackTimer.start()

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
	if GameManager.targetenemy == self:
		GameManager.targetenemy = null
	queue_free()

func _on_Movetimer_timeout():
	move = false
	$AttackTimer.start()



func _on_StaticEnemy_area_entered(area):
	if area.is_in_group("EnemyBack"):
		move = false
		$AttackTimer.stop()
		pass
	if area.is_in_group("Missile1"):
		take_damage()
	if area.is_in_group("Missile2"):
		hp -=2
		take_damage()
	if area.is_in_group("Missile3"):
		hp -=3
		take_damage()


func _on_EnemyDetectArea_area_entered(area):
	if area.name == "RadarBoundaryArea" or area.is_in_group("Missile3Radar"):
		if GameManager.targetenemy == null:
			GameManager.targetenemy = self
			print(GameManager.targetenemy)


func _on_EnemyDetectArea_area_exited(area):
	if area.is_in_group("EnemyBack"):
		$AttackTimer.start()


func _on_CrossButton_pressed():
	GameManager.crossenemy = self
	GameManager.playertank.cross_shoot()
