extends Node2D



func _ready():
	$AnimationPlayer2.play("ProjectAni")
	$LogoAnimation.play("LogoAni")
	GameManager._load()
#	PlayServices.play_service.signIn()
	
  

func _process(delta):

	if $ComingSoon.rect_scale == Vector2(2,2):
		
		var tween = get_tree().create_tween()
	
		tween.tween_property($ComingSoon, "rect_scale",Vector2(3,3),1)
	
		tween.play()
	if $ComingSoon.rect_scale == Vector2(3,3):
		var tween = get_tree().create_tween()
	
		tween.tween_property($ComingSoon, "rect_scale",Vector2(2,2),1)
	
		tween.play()


	$ProjectPanzer.percent_visible +=0.5 * delta
	$VersionLabel.percent_visible += 0.5 * delta
	
	$ParallaxBackground/ParallaxLayer.motion_offset.y += 200 * delta


func _on_PlayButton_pressed():
	$AnimationPlayer3.play("PlayAni")




func _on_SettingsButton_pressed():
	get_tree().change_scene('res://Scenes/Menu/Settings.tscn')
	
	



func _on_Credits_pressed():
	get_tree().change_scene("res://MultiPlayer/lobby/lobby.tscn") 


func _on_Logo42_pressed():

	OS.shell_open("https://www.instagram.com/studyo42/")


func _on_AnimationPlayer3_animation_finished(anim_name):
	if anim_name == 'PlayAni' :
		get_tree().change_scene("res://Scenes/Game/Hangar.tscn")


func explo():
	$AnimationPlayer.play("ExplosionAni")
