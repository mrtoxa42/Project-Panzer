extends CPUParticles2D


var smoke = false
func _ready():
	emitting = true
	$AnimationPlayer.play("ParticleAni")
	

func _on_DeathTimer_timeout():
	queue_free()


