extends KinematicBody2D

var speed = 750
var velocity = Vector2(0,0)
var screen = true
var radiosignal = preload("res://Scenes/Levels/LevelsEnd/RadioSignal.tscn")



func _process(delta):
	look_at(GameManager.levelend)
	velocity = Vector2(GameManager.levelend - global_position).normalized()
	if screen == true:
		move_and_slide(velocity * speed)
   

func _on_VisibilityNotifier2D_screen_entered():
	screen = true


func _on_VisibilityNotifier2D_screen_exited():
	screen = false
	$SignalTimer.start()

func _on_SignalTimer_timeout():
	var RadioSignal = radiosignal.instance()
	get_tree().get_root().add_child(RadioSignal)
	RadioSignal.global_position = global_position - Vector2(75,75 )
	if screen == false:
		$SignalTimer.start()
