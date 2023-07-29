extends Node2D



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani1":
		get_tree().change_scene("res://Scenes/Levels/LevelsScene.tscn")
