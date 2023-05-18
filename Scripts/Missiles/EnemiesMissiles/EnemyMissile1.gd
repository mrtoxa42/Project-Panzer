
extends KinematicBody2D


var speed = 500
var direction = Vector2(0,0)
var shootfollow = true


func _ready():
	if GameManager.playertank != null:
		direction = GameManager.playertank.global_position - global_position


func _process(delta):
	if GameManager.inlevel == false:
		queue_free()
	if shootfollow == true and GameManager.playertank != null:
		look_at(GameManager.playertank.global_position)
		direction = (GameManager.playertank.global_position - global_position).normalized()
	var velocity = move_and_collide(direction * speed * delta)
	
	


func _on_FollowTimer_timeout():
	shootfollow = false



func _on_EnemyMissile1_area_entered(area):
	if area.is_in_group("Player"):
		queue_free()
	if area.is_in_group("Bush"):
		queue_free()




func _on_DeathTimer_timeout():
	queue_free()


