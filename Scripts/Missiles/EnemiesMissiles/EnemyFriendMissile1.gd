extends KinematicBody2D




var speed = 500
var direction = Vector2(0,0)
var targetposition = Vector2.ZERO
var target 
var shootfollow = true


func _ready():
	pass
func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	if target != null:
		direction = (targetposition - global_position).normalized()
		move_and_collide(direction * speed * delta)

	
	


func _on_DeathTimer_timeout():
	queue_free()


func _on_DetectArea_area_entered(area):
		if area.is_in_group("Friend"):
			if target == null:
				target = area
				targetposition = area.global_position
				look_at(area.global_position)
	

func _on_MissileArea_area_entered(area):
	if area.is_in_group("FriendTank"):
		queue_free()
	if area.is_in_group("Tree"):
		queue_free()
	if area.name == "PlayerArea":
			queue_free()
