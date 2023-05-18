extends KinematicBody2D

var speed = 1
var direction = Vector2(0,0)
var shootfollow = true
var target

var velocity2 = Vector2(0,0)
var look = true

func _ready():
	direction = GameManager.playertank.global_position - global_position
	velocity2 = GameManager.playertank.move
	look_at(GameManager.playertank.CrossHair.global_position)


func _process(delta):
	if shootfollow == true and target != null and look == false:
		look_at(target.global_position)
		if target != null:
			speed = 420
			direction = (target.global_position- global_position).normalized()
			var velocity = move_and_collide(direction * speed * delta)
	else:
		if look == true:
			look_at(GameManager.playertank.CrossHair.global_position)
		position -= velocity2  * speed * delta
#	if GameManager.targetenemy == null:
#		if GameManager.playertank !=null:
#				positio n -= velocity2  * speed * delta
	


func _on_LookTimer_timeout():
	look = false


func _on_Missile3_area_entered(area):
	if area.is_in_group("Enemies"):
		queue_free()


func _on_DeathTimer_timeout():
	queue_free()


func _on_Missile3Radar_area_entered(area):
	if area.is_in_group("Enemy"):
		if target ==null:
			target = area


func _on_Missile3Radar_area_exited(area):
	if area.is_in_group("Enemy"):
		if target == area:
			target = null
