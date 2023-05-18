extends CPUParticles2D


var smoke = false
func _ready():
	emitting = true

func _on_DeathTimer_timeout():
	queue_free()

func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	if smoke == false:
		if modulate.a <255:
			modulate.a += 0.2 * delta
	else:
		smoke = true
		
	if smoke == true:
		modulate.a -= 0.1 * delta
	
