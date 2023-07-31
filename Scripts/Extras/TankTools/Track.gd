extends Sprite



func _ready():
	rotation = GameManager.TrackRotation









func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
