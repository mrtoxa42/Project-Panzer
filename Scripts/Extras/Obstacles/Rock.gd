extends Area2D




var speed = 300

func _process(delta):
	position.x -= speed * delta
	if GameManager.inlevel == false:
		queue_free()


func _on_Rock_area_entered(area):
	if area.is_in_group("ObstacleMissile"):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
