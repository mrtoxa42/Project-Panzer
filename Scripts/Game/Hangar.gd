extends Node2D



func _ready():
	$NextLevelLabel.text = "PLAY NEXT LEVEL: " +"\n"+ "                      " + str(GameManager.game_data.nextlevel)
	$AnimationPlayer.play("PlayerHangarAni")
	GameManager._save()
	if GameManager.game_data.nextlevel == 3:
		faultshoot()
	
	GameManager.hangarinterstitialcounter+=1
	$AdMob.load_banner()
	$AdMob.load_interstitial()
	$AdMob.load_rewarded_video()
	$AdMob.show_banner()
	
	if  GameManager.hangarinterstitialcounter==2 :
		$AdMob.show_interstitial()
		GameManager.hangarinterstitialcounter= 0
	




func _process(_delta):
	$MedalLabel.text = str(GameManager.player_data.Medal1)
	$Medal2Label.text = str(GameManager.player_data.Medal2)
	$Inventory/Missile2Label.text = str(GameManager.player_data.Missile2)
	$Inventory/Missile3Label.text = str(GameManager.player_data.Missile3)
	$Inventory/RepairKitLabel.text = str(GameManager.player_data.RepairKit)


func _on_RepairKitBuyButton_pressed():
	if GameManager.player_data.Medal1 >=10:
		GameManager.player_data.RepairKit +=1
		GameManager.player_data.Medal1 -= 10

func _on_Missile3BuyButton_pressed():
	if GameManager.player_data.Medal1 >=10:
		GameManager.player_data.Missile3 +=1
		GameManager.player_data.Medal1 -= 10
func _on_Missile2BuyButton_pressed():
	if GameManager.player_data.Medal1 >=10:
		GameManager.player_data.Missile2 +=1
		GameManager.player_data.Medal1 -= 10


func _on_LevelsButton_pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelsScene.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")


func _on_NextLevelButton_pressed():
	if GameManager.game_data.nextlevel == 1:
		get_tree().change_scene("res://Scenes/Levels/HistoryStart.tscn")
	else:
		get_tree().change_scene("res://Scenes/Levels/Level"+ str(GameManager.game_data.nextlevel) +".tscn")
	

func _on_ResetLoad_pressed():
	GameManager.delete_save()


func faultshoot():
	if $faultshoot/Sprite.scale == Vector2(2,2):
		var tween = get_tree().create_tween()
		tween.tween_property($faultshoot/Sprite, "scale",Vector2(3,3),1)
		tween.play()
		tween.connect("finished",self,"tween_finished")
	if $faultshoot/Sprite.scale == Vector2(3,3):
		var tween = get_tree().create_tween()
		tween.tween_property($faultshoot/Sprite, "scale",Vector2(2,2),1)
		tween.play()
		tween.connect("finished",self,"tween_finished")

func tween_finished():
	faultshoot()


func _on_AdMob_interstitial_loaded():
#	$AdMob.show_interstitial()
	pass


func _on_AdMob_rewarded(currency, amount):
	GameManager.crossfixed = true


func _on_FaultButton_pressed():
	$AdMob.load_rewarded_video()



func _on_AdMob_rewarded_video_loaded():
	$AdMob.show_rewarded_video()
