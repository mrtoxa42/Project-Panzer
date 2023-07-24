extends KinematicBody2D


var velocity = Vector2.ZERO
var hp = 10
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")
var shoottime = true
export var speed = 200
var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/BossPlayerMissile/BossPlayerMissile1.tscn")


func _ready():
	GameManager.bossplayer = self
	

func _on_RightButton_pressed():
	velocity.x = 1


func _on_LeftButton_pressed():
	velocity.x = -1


func _on_RightButton_released():
	velocity.x = 0


func _on_LeftButton_released():
	velocity.x = 0

func _on_FireButton_pressed():
	var Missile1 = missile1.instance()
	get_tree().get_root().add_child(Missile1)
	Missile1.global_position = $ShootPosition.global_position

func _process(delta):
	move_and_slide(velocity * speed)


func play_fight():
	$CanvasLayer/RightButton.show()
	$CanvasLayer/LeftButton.show()
	$CanvasLayer/FireButton.show()


func _on_BossPlayerArea_area_entered(area):
	if area.is_in_group("BossMissile"):
		var Explosion = explosion.instance()
		get_tree().get_root().add_child(Explosion)
		Explosion.global_position = $MissileExplosionPosition.global_position
		hp -= 1


func _on_ShootTimer_timeout():
	shoottime = true
