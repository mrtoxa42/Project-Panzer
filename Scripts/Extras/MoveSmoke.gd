extends CPUParticles2D


var smoke = false
var speed = 38
func _ready():
	emitting = true
	$AnimationPlayer.play("ParticleAni")
	if GameManager.playertank != null:
		if GameManager.playertank.velocity >= Vector2(0.5,0.5):
			gravity = Vector2(-speed,0)
		else:
			gravity = Vector2(speed,0)
	

func _on_DeathTimer_timeout():
	speed = 200


func _process(delta):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
