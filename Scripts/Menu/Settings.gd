extends Node2D

var musicvalue = 0
var sfxvalue = 0


func _ready():
	$AniNode/MusicSlider.value = GameManager.game_data.musicvalue
	$AniNode/SfxSlider.value = GameManager.game_data.sfxvalue
	$AnimationPlayer.play("ReadyAni")
	

func _process(delta):
	
	musicvalue = $AniNode/MusicSlider.value
	sfxvalue = $AniNode/SfxSlider.value
	
	GameManager.game_data.musicvalue = musicvalue
	GameManager.game_data.sfxvalue = sfxvalue
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), musicvalue)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"),sfxvalue)
	

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")



func _on_MusicSlider_mouse_exited():
	$AniNode/MusicSlider.release_focus()
	$AniNode/SfxSlider.release_focus()
