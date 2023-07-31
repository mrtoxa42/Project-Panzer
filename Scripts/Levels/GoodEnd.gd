extends Node2D


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		$AnimationPlayer.play("Ani2")

	if anim_name == "Ani2":
		get_tree().change_scene("res://Scenes/Game/Hangar.tscn")
