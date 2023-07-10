extends Node2D



func _ready():
	$NextLevelLabel.text = "PLAY NEXT LEVEL: " +"\n"+ "                      " + str(GameManager.game_data.nextlevel)
	$AnimationPlayer.play("PlayerHangarAni")
	GameManager._save()
	if GameManager.game_data.nextlevel == 3:
		faultshoot()






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
	if $faultshoot/Label.rect_scale == Vector2(1,1):
		var tween = get_tree().create_tween()
		tween.tween_property($faultshoot/Label, "rect_scale",Vector2(1.3,1.3),1)
		tween.play()
		tween.connect("finished",self,"tween_finished")
	if $faultshoot/Label.rect_scale == Vector2(1.3,1.3):
		var tween = get_tree().create_tween()
		tween.tween_property($faultshoot/Label, "rect_scale",Vector2(1,1),1)
		tween.play()
		tween.connect("finished",self,"tween_finished")

func tween_finished():
	faultshoot()
