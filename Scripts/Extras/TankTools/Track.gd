extends Sprite



func _ready():
	rotation = GameManager.TrackRotation






func _on_DeathTimer_timeout():
	queue_free()
