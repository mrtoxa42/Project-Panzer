extends KinematicBody2D


var missile = preload("res://Scenes/Missiles/PlayerMissiles/ObstacleMissile.tscn")
var shoot = true
var speed = 15000
var up = false
var down = false
var velocity = Vector2.ZERO

func _on_AreaMovePlayer_area_entered(area):
	if area.is_in_group("Obstacle"):
		GameManager.levelcomplete = false
		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")


func _process(delta):
	velocity = Vector2.ZERO
	if up == true:
		velocity.y = -1
	elif down == true:
			velocity.y = 1
	
	move_and_slide(velocity * speed * delta)
func _on_UpDown_pressed():
	up = true


func _on_UpDown_released():
	up = false


func _on_DownButton_pressed():
	down = true


func _on_DownButton_released():
	down = false


func _on_ShootButton_pressed():
	if shoot == true:
		$PlayerAnimated.play("Fire")
		var Missile = missile.instance()
		get_tree().get_root().add_child(Missile)
		Missile.global_position = $ShootPosition.global_position
		$CanvasLayer/ShootButtonAni.play("Shoot")
		shoot = false
		$ShootTimer.start()
		


func _on_ShootButtonAni_animation_finished():
	if $CanvasLayer/ShootButtonAni.animation == "Shoot":
		$CanvasLayer/ShootButtonAni.play("default")


func _on_ShootTimer_timeout():
	shoot = true


func _on_PlayerAnimated_animation_finished():
	if $PlayerAnimated.animation == "Fire":
		$PlayerAnimated.play("default")
