extends CanvasLayer


func _ready():
#	SoundController.tank_move_stop()
	GameManager.inlevel = false
	$AnimationPlayer.play("Ani")
	GameManager._save()
	
	if GameManager.levelcomplete == true:
		$LabBut/RichTextLabel.bbcode_text = "[wave amp=100sss freq=2] MISSION COMPLETE"
		$LabBut/NexLevelLabel.modulate.a = 1
		if GameManager.gathermedal ==1:
			$Medal1.modulate.a = 1
			$MedaalsLabels/MedalPlus1.percent_visible = 1
			GameManager.player_data.Medal1 +=100
		if GameManager.gathermedal ==2:
			$MedaalsLabels/MedalPlus1.percent_visible = 1
			$MedaalsLabels/MedalPlus2.percent_visible = 1
			GameManager.player_data.Medal1 +=200
			$Medal1.modulate.a = 1
			$Medal2.modulate.a = 1
		if GameManager.gathermedal ==3:
			$MedaalsLabels/MedalPlus1.percent_visible = 1
			$MedaalsLabels/MedalPlus2.percent_visible = 1
			$MedaalsLabels/MedalPlus3.percent_visible = 1
			GameManager.player_data.Medal1 +=300
			$Medal1.modulate.a = 1
			$Medal2.modulate.a = 1
			$Medal3.modulate.a = 1
	else:
		$LabBut/RichTextLabel.bbcode_text = "[wave amp=100 freq=2] MISSION FAILED"
		$LabBut/NexLevelLabel.modulate.a = 0.1
func _on_NextLevelButton_pressed():
	if GameManager.levelcomplete == true:
		get_tree().change_scene("res://Scenes/Levels/Level" + str(GameManager.game_data.nextlevel) +".tscn")




func _on_ReplayButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level"+ str(GameManager.CurrentLevel) +".tscn")


func _on_HangarButton_pressed():
	get_tree().change_scene("res://Scenes/Game/Hangar.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Ani":
		$AnimationPlayer.play("Ani2")
		if GameManager.gathermedal2 == true:
			$AnimationPlayer.play("Medal2ani")
	if anim_name == "Medal2ani":
		GameManager.gathermedal2 = false
