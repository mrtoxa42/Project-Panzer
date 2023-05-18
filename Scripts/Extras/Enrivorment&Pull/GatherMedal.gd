extends Area2D


var onecollision = true


func _on_GatherMedal_area_entered(area):
	if area.name == "PlayerArea" and onecollision == true:
		$AnimationPlayer.play("Gather")
		onecollision = false



func _on_AnimationPlayer_animation_finished(anim_name):
	GameManager.gathermedal +=1
	queue_free()
