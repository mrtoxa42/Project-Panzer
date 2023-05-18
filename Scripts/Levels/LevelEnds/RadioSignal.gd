extends AnimatedSprite

func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	if GameManager.playertank !=null:
		look_at(GameManager.playertank.global_position)

func _on_DeathTimer_timeout():
	queue_free()
