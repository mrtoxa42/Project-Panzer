extends Area2D



var speed = 200

func _process(delta):
	position.x += speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_ObstacleMissile_area_entered(area):
	if area.is_in_group("Obstacle"):
		queue_free()
