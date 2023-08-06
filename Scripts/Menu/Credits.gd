extends Node2D


#func _ready():
#	$AnimationPlayer.play("TileAni")
#
#
#func _process(delta):
#	$Labels.modulate.a += 0.4 * delta
func _on_CreditsBack_pressed():
	SoundController.UIClickSound()
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")

func _ready():
	$AnimationPlayer.play("Ani")
