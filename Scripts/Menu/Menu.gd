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


func _on_FeedBackButton_pressed():
	$FeedBack/LineEdit.show()
	$FeedBack/GoMail.show()
	$FeedBack/BackBlackButton.show()
	$FeedBack/BlackSprite.show()
	get_tree().paused = true


func _on_GoMail_pressed():
	var body = $FeedBack/LineEdit.text
	OS.shell_open("mailto:studyo42@outlook.com.tr?subject=Project Panzer Geri Bildirimi&body=" + body)


func _on_BackBlackButton_pressed():
	$FeedBack/LineEdit.hide()
	$FeedBack/GoMail.hide()
	$FeedBack/BackBlackButton.hide()
	$FeedBack/BlackSprite.hide()
	var timer = Timer.new()
	get_tree().get_root().add_child(timer)
	timer.pause_mode = PAUSE_MODE_PROCESS
	print(timer)
	timer.connect("timeout",self,"on_timeout")
	timer.wait_time = 0.2
	timer.one_shot = true
	timer.start()
func on_timeout():
	get_tree().paused = false
