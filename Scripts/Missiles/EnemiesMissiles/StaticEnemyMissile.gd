extends Area2D

var speed = 350

func _process(delta):
	position.x -= speed * delta
	if GameManager.inlevel == false:
		queue_free()


func _on_StaticEnemyMissile_area_entered(area):
	if area.name == "StationArea":
		queue_free()
	if area.name == "PlayerArea":
		queue_free()


func _on_Timer_timeout():
	queue_free()
