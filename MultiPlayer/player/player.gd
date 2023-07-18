extends KinematicBody2D

signal player_ready

const BULLET = preload("res://MultiPlayer/player/playerbullet.tscn")

const MAXSPEED = 100
const ACCELERATION = 300
const FRICTION = 200

var motion = Vector2.ZERO

var can_fire = true

var player_color = "fff"

onready var world = get_tree().get_root().get_node("World")

onready var player_label = $Label
onready var camera = $Camera2D
onready var bullet_loc = $BulletFireLoc
onready var fire_rate = $FireRate
onready var collision = $CollisionPolygon2D


func _ready():
	player_label.set_as_toplevel(true)
	set_player_name()
	player_color = Server.players[int(name)]["local_color"]
	set_color()
	emit_signal("player_ready")

func _physics_process(delta):
	if is_network_master():
		camera.current = true
		player_label.rect_position = Vector2(position.x - 40, position.y - 60)
		var input_vector = get_input_vector()
		apply_movement(input_vector, delta)
		apply_friction(input_vector, delta)
		motion = move_and_slide(motion)
		fire()
		
		rpc_unreliable_id(1, "update_player", global_transform)
		
remote func update_remote_player(transform):
	if not is_network_master():
		global_transform = transform
		player_label.rect_position = Vector2(position.x - 40, position.y - 60)
		
	
	
func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_vector.normalized()
	
	
func apply_movement(input_vector, delta):
	look_at(get_global_mouse_position())
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * MAXSPEED, ACCELERATION * delta)

		
func apply_friction(input_vector, delta):
	if input_vector == Vector2.ZERO:
		motion = motion.move_toward(Vector2.ZERO, FRICTION * delta)
		
func set_player_name ():
	player_label.text = Server.players[int(name)]["Player_name"]
	
func fire():
	if Input.is_action_pressed("z") and can_fire:
		rpc_id(1, "player_bullet")
		can_fire = false
		fire_rate.start()
		
sync func spawn_bullet():
	var bullet_instance = BULLET.instance()
	world.add_child(bullet_instance)
	bullet_instance.modulate = player_color
	bullet_instance.transform = bullet_loc.global_transform
	
func _on_FireRate_timeout():
	can_fire = true
	

func damage():
	if is_network_master():
		world.show_gui("You Died")
	rpc_id(1, "die")
	
sync func player_died():
	set_physics_process(false)
	collision.disabled = true
	hide()
	player_label.hide()
	
	
func set_color():
	modulate = player_color
	
