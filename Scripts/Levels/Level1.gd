extends Node2D

#Cinematic e ait değişkenler
var cinematic = 1
var cinematic1 = true
var cinematic1boundaryspeed = 3
var cinematic1cameraboundary = 3
var cinematictankspeed = 75
var cinematic1bulletspeed = 700
var camreashake = false

var tuttime = 0
#Cinematic e ait değişkenler
var endradar = preload("res://Scenes/Extras/TankTools/EndRadar.tscn")
var playertank = preload("res://Scenes/Player/PlayerTank.tscn")

func _ready():
	GameManager.inlevel = true
	GameManager.game_data.currentlevel = 1
	GameManager.playedlevel = self
	GameManager.CurrentLevel = 1
#	GameManager.levelend = $Level1EndArea.global_position 
	
	

func _process(delta):
	if $Enemy1 != null and $Tutorial2/FingerPoint != null:
		$Tutorial2/FingerPoint.global_position = $Enemy1.global_position



func cinematic2():
	$FireTimer.start()
	$CanvasLayer/Cinematic2/Cinematic2timer.start()

		
func cinematic3():
	$CanvasLayer/Cinematic2.hide()
	var EndRadar = endradar.instance()
	get_tree().get_root().add_child(EndRadar)

	


func _on_Cinematic2End_timeout():
	cinematic = 3
	cinematic3()





func _on_Cinematic2timer_timeout():
	cinematic = 2
	var PlayerTank = playertank.instance()
	get_tree().get_root().add_child(PlayerTank)
	PlayerTank.global_position = $Cinematic1/Tank2.global_position
	$CanvasLayer/Cinematic2.show()
	$Cinematic1/Tank2.queue_free()
	$Cinematic1.hide()


func _on_FireTimer_timeout():
	$FireParticle.show()
	$FireParticle2.show()




func _on_AniSkipButton_pressed():
	$Cinematic1/AnimationPlayer.playback_speed = 64
	$CanvasLayer2/AniSkipTimer.start()

	$Level1Ani.playback_speed = 64
	

func _on_AniSkipTimer_timeout():
	$Cinematic1/AnimationPlayer.playback_speed = 1
	$Level1Ani.playback_speed = 1
	


func _on_Level1Ani_animation_finished(anim_name):
	if anim_name == "Ani1":
		$Cinematic1/AnimationPlayer.play("CameraShake")
	if anim_name == "Ani2":
		$Level1Ani.play("Ani3")
	if anim_name == "Ani3":
		$CanvasLayer/Cinematic2.queue_free()
		$TutorialAni.play("Tut1Ani")
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "CameraShake":
		$Level1Ani.play("Ani2")


func game_started():
	var player = playertank.instance()
	get_tree().get_root().add_child(player)
	player.global_position = $Cinematic1/Tank2.global_position
	$Cinematic1/Tank2.queue_free()
	


func _on_TutorialAni_animation_finished(anim_name):
	if anim_name == "Tut1Ani":
		$Tutorial/TutorialTimer.start()


func _on_TutClose_pressed():
	$Tutorial.queue_free()
	
	get_tree().paused = false
	game_started()





func _on_TutorialTimer_timeout():
	if tuttime < 0:
		tuttime +=1
		var i = 7 - tuttime
		$Tutorial/TutorialTimer.start()
		$Tutorial/SkipTime.text = "GEÇMEK İÇİN... " + str(i)
	else:
		$Tutorial/TutClose.show()
		$Tutorial/SkipTime.text = "GEÇMEK İÇİN " + "TIKLAYIN"
	


func _on_Tut1Area_area_entered(area):
	if area.name == "PlayerArea":
		tut2area()
		
func tut2area():
	$Tutorial2/MedalLabel.show()
	$Tutorial2/FingerPoint.show()
	$Tutorial2/EnemyLabel.show()
	$Tutorial2/Tut2Ani.play("FingerPoint")


func _on_ClickDestroyed_pressed():
	$Tutorial2.queue_free()
