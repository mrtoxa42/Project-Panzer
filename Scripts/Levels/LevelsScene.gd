extends Node2D

var level = 1
var openinfo = false

func _ready():
	$AnimationPlayer.play("ReadyAni")
	level_enter()
	
	
	
		
		
func level_enter():
	if GameManager.game_data.nextlevel <2:
		$LevelAni/Level2/LevelButton2.modulate.a = 0.5
		$LevelAni/Level3/LevelButton3.modulate.a = 0.5
		$LevelAni/Level4/LevelButton4.modulate.a = 0.5
		$LevelAni/Level5/LevelButton5.modulate.a = 0.5
		$LevelAni/Level6/LevelButton6.modulate.a = 0.5
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
		
	elif GameManager.game_data.nextlevel <3:
		$LevelAni/Level3/LevelButton3.modulate.a = 0.5
		$LevelAni/Level4/LevelButton4.modulate.a = 0.5
		$LevelAni/Level5/LevelButton5.modulate.a = 0.5
		$LevelAni/Level6/LevelButton6.modulate.a = 0.5
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <4:
		$LevelAni/Level4/LevelButton4.modulate.a = 0.5
		$LevelAni/Level5/LevelButton5.modulate.a = 0.5
		$LevelAni/Level6/LevelButton6.modulate.a = 0.5
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <5:
		$LevelAni/Level5/LevelButton5.modulate.a = 0.5
		$LevelAni/Level6/LevelButton6.modulate.a = 0.5
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <6:
		$LevelAni/Level6/LevelButton6.modulate.a = 0.5
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <7:
		$LevelAni/Level7/LevelButton7.modulate.a = 0.5
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <8:
		$LevelAni/Level8/LevelButton8.modulate.a = 0.5
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <9:
		$LevelAni/Level9/LevelButton9.modulate.a = 0.5
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <10:
		$LevelAni/Level10/LevelButton10.modulate.a = 0.5
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <11:
		$LevelAni/Level11/LevelButton11.modulate.a = 0.5
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	elif GameManager.game_data.nextlevel <12:
		$LevelAni/Level12/LevelButton12.modulate.a = 0.5
	else:
		pass


func _on_LevelButton1_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton2_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton3_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton4_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true
func _on_LevelButton5_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton6_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton7_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton8_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton9_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton10_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func _on_LevelButton11_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true


func _on_LevelButton12_pressed():
	if openinfo == false:
		level = 1
		level_info()
		openinfo = true

func level_info():
	$AnimationPlayer.play("LevelInfoAni")
	
	if level == 1:
		$InfoTab/LevelLabel.text = "LEVEL 1"
		$InfoTab/InfoLabel.text = "Kiril için yeni görev..."+ "\n" + "\n"+ "- Radyo istasyonuna git" +"\n"+"\n"+"- 3 madalyayı topla"+"\n"+"\n"+"- 9 düşmanı öldür"
	if level == 2:
		$InfoTab/LevelLabel.text = "LEVEL 2"
		$InfoTab/InfoLabel.text = "Radyo istasyonu en büyük iletişim kaynağıdır." + "\n" + "\n" + "- Radyo istasyonunu koru" +"\n"+"\n"+"- 3 madalyayı topla"+"\n"+"\n"+"- x düşman öldür"
	if level == 3:
		$InfoTab/LevelLabel.text = "LEVEL 3"
		$InfoTab/InfoLabel.text = "Düşman cephaneliği hakkında bilgi alman " + "\n" + "gerekiyor." + "\n" + "\n" + "- Radyo sinyallerini takip et" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- 13 Düşman öldür"
	if level == 4:
		$InfoTab/LevelLabel.text = "LEVEL 4"
		$InfoTab/InfoLabel.text = "Cephanelik hakkında yeterince bilgi aldın, orayı" + "\n" + "patlatma zamanı.Ayrıca bir askerin yaptığı en iyi" + "\n" + "iş gizliliktir." + "\n" + "\n" + "- Düşman askerlerinin radarına girme" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- Gizlice radyo istasyonuna ulaş"
	if level == 5:
		$InfoTab/LevelLabel.text = "LEVEL 5"
		$InfoTab/InfoLabel.text = "Geri dönme zamanı,dikkatli ol!" + "\n" + "\n" + "- Radyo sinyallerini takip et" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- 9 Düşman öldür"
	if level == 6:
		$InfoTab/LevelLabel.text = "LEVEL 6"
		$InfoTab/InfoLabel.text = "Su uyur düşman uyumaz, her zaman hazırlı olmak" + "\n" + "gerekir." + "\n" + "\n" + "- Baskına karşı savun " +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- x Düşman öldür"
	if level == 7:
		$InfoTab/LevelLabel.text = "LEVEL 7"
		$InfoTab/InfoLabel.text = "Hapishaneden kaçış!" + "\n" + "\n" + "- Dost askerleri kurtar" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- Düşman askere karşı gizlen"
	if level == 8:
		$InfoTab/LevelLabel.text = "LEVEL 8"
		$InfoTab/InfoLabel.text = "Dostlarınla birlikte düşmanları temizle." + "\n" + "\n" + "-Dostlarının ölmesine izin verme " +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- 11 Düşman öldür"
	if level == 9:
		$InfoTab/LevelLabel.text = "LEVEL 9"
		$InfoTab/InfoLabel.text = "Savaşın kazananı yoktur." + "\n" + "\n" + "- Dostlarını koru" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- Tüm düşmanları yok et"
	if level == 10:
		$InfoTab/LevelLabel.text = "LEVEL 10"
		$InfoTab/InfoLabel.text = "Konvoy seni fark etmedi, onları takip et  ve " + "\n" + "nereye gittiklerini öğren." + "\n" + "\n" + "- Engellere takılma" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"- Konvoyu takip et"
		
	if level == 11:
		$InfoTab/LevelLabel.text = "LEVEL 11"
		$InfoTab/InfoLabel.text = "Esaretin bedeli." + "\n" + "\n" + "- Kaderine karşı çıkamazsın!" +"\n"+"\n"+"- Düşmana karşı asla pes etme"+"\n"+"\n"+"- Son umut"
	
	if level == 12:
		$InfoTab/LevelLabel.text = "LEVEL 12"
		$InfoTab/InfoLabel.text = "Artık oyunun sonundayız..." + "\n" + "\n" + "- Büyük savaşı kaybetme!" +"\n"+"\n"+"- 3 Madalyayı topla"+"\n"+"\n"+"-Hitleri öldür "


func _on_CloseButton_pressed():
	openinfo = false
	$InfoTab.hide()


func _on_PlayButton_pressed():
	if level <= GameManager.game_data.nextlevel:
		get_tree().change_scene("res://Scenes/Levels/Level"+str(level)+".tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Game/Hangar.tscn")
