extends Path2D







func _process(delta):
	$PathFollow2D.offset += 450 * delta


func _on_BossMissile2Area_area_entered(area):
	if area.name == "BossPlayerArea":
		queue_free()

func _on_DeathTimer_timeout():
	queue_free()
