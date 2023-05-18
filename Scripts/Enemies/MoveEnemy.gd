extends KinematicBody2D


var direction = ""
var speed = 200
var rng = RandomNumberGenerator.new()
var playmove = false
func _ready():
	pass
	

func _process(delta):
	if playmove == false and GameManager.level4move == true:
		$MoveTimer.start()
		playmove = true
	if GameManager.inlevel == false:
		queue_free()
	if direction == "Right":
		if global_position.x < 5620:
			rotation_degrees = 90
			position.x += speed * delta
	elif direction == "Left":
		if global_position.x > 1 :
			rotation_degrees = -90
			position.x -= speed * delta
	elif direction == "Up":
		if global_position.y > 1:
			rotation_degrees = 0
			position.y -= speed * delta
	elif direction == "Down":
		if global_position.y <2850:
			rotation_degrees = 180
			position.y += speed * delta
	






func _on_MoveTimer_timeout():
	$MoveTimer.wait_time = 3
	rng.randomize()
	var r = rng.randi_range(0,3)
	if r == 0:
		direction = "Right"
	elif r == 1:
		direction = "Left"
	elif r ==2:
		direction = "Up"
	elif r ==3:
		direction = "Down"


func _on_DetectArea_area_entered(area):
	if area.name == "PlayerArea":
		print("a")
#		if GameManager.playertank.bush == false:
#			GameManager.levelcomplete = false
#			GameManager.inlevel = false
#			get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
		pass
	if area.is_in_group("MoveEnemy"):
#		direc()
		pass

func direc():
	rng.randomize()
	var r = rng.randi_range(0,3)
	if r == 0:
		direction = "Right"
	elif r == 1:
		direction = "Left"
	elif r ==2:
		direction = "Up"
	else:
		direction = "Down"
