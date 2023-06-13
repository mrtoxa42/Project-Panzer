extends Node2D


var ani = 0



func _ready():
	$AnimationPlayer.play("Ani1")
	ani = 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		tween_label()
		$Cine1/SkipLabel.show()
		$Cine1/SkipButton.show()
		PlayServices.yeni_baslangic()
		
	if anim_name == "Ani2":
		get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
		
	
		
		
		
func tween_label():
	if $Cine1/SkipLabel != null:
		if $Cine1/SkipLabel.modulate == Color(1,1,1,1):
			var tween = get_tree().create_tween()
			tween.tween_property($Cine1/SkipLabel,"modulate",Color(1,1,1,0),1)
			tween.connect("finished",self,"tween_finished")
		if $Cine1/SkipLabel.modulate == Color(1,1,1,0):
			var tween = get_tree().create_tween()
			tween.tween_property($Cine1/SkipLabel,"modulate",Color(1,1,1,1),1)
			tween.connect("finished",self,"tween_finished")

func tween_finished():
	tween_label()


func _on_SkipButton_pressed():
	if ani == 1:
		ani = 2
		$Cine1.queue_free()
		$AnimationPlayer.play("Ani2")
