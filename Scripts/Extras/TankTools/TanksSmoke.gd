extends CPUParticles2D



func _ready():
#	global_position = GameManager.playertank.global_position
	emitting = true


func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	self_modulate.a -=1 * delta



func _on_DeathTimer_timeout():
	queue_free()
