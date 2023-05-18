extends Area2D



var speed = 2
var playerdirection = ""
var velocity = Vector2(0,0)
var look = true

func _ready():
	
	velocity = GameManager.playertank.move
	look_at(GameManager.playertank.CrossHair.global_position)



func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
#	if playerdirection == 'Right' :
#		rotation_degrees = 90
#		position.x +=speed * delta
#	if playerdirection == 'Left' :
#		rotation_degrees =-90
#		position.x -=speed * delta
#	if playerdirection == 'Up' :
#		rotation_degrees = 0
#		position.y -=speed * delta
#	if playerdirection == 'Down' :
#		rotation_degrees = 180
#		position.y +=speed * delta
	if look == true:
		look_at(GameManager.playertank.CrossHair.global_position)
	position -= velocity  * speed * delta


func _on_LooktTimer_timeout():
	look = false


func _on_Missile1_area_entered(area):
	if area.is_in_group("Enemies"):
		queue_free()
	if area.is_in_group("Tree"):
		queue_free()




func _on_DeathTimer_timeout():
	queue_free()
