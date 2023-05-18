extends Node2D


func _on_AnimationPlayer_animation_finished(anim_name):
#	if anim_name == "EntertaimentAnimation":
#		$AnimationPlayer.play("PresentAnimation")
	if anim_name == "PresentAnimation":
		get_tree().change_scene("res://Scenes/Menu/Menu.tscn")


func _ready():
	print("github")

