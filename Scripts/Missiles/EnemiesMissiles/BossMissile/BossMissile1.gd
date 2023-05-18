extends Area2D




func _process(delta):
	position.y  += 200 * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_BossMissile1_area_entered(area):
	if area.name == "BossPlayerArea":
		queue_free()
