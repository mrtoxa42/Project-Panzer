extends Area2D


onready var  big_circle = $BigCircle
onready var small_circle = $BigCircle/SmallCircle
var rotspeed = 250
onready var max_distance = $CollisionShape2D.shape.radius

var touched = false

func _ready():
	GameManager.joystick = self
	modulate.a = 0.5



func _input(event):
	if touched == true:
		var distance = event.position.distance_to(big_circle.global_position)
		if not touched:
			if distance<max_distance:
				touched = true
#		else:
#			small_circle.position = Vector2.ZERO
#			touched = false
	
func _process(delta):
	if touched:
		small_circle.global_position = get_global_mouse_position()
		small_circle.position = big_circle.position + (small_circle.position - big_circle.position).clamped(max_distance)
		var direction = small_circle.global_position - big_circle.global_position
		if direction.length_squared() > 0.1:
			if GameManager.playertank !=null:
				GameManager.playertank.rotation = direction.angle()

func get_velo():
	var joy_velo = Vector2.ZERO
	joy_velo.x = small_circle.position.x/ max_distance
	joy_velo.y = small_circle.position.y / max_distance
	return joy_velo


func _on_TouchButton_pressed():
	GameManager.playertank.track_timer()
	touched = true
	modulate.a = 1



func _on_TouchButton_released():
	touched = false
	$BigCircle/SmallCircle.position = Vector2.ZERO
	modulate.a = 0.5


