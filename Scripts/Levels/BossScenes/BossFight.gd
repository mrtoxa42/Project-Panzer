extends Node2D


var touch = false


func _process(delta):
	$Invisible/HitlerHp.value = GameManager.bosshitler.hp
	$Invisible/PlayerHp.value = GameManager.bossplayer.hp
	


func _on_AttackButton_pressed():
	if touch == false:
		touch = true
		$Invisible/HitlerLabel.text = "* Bende bunu istiyordum"
		$Invisible/PlayerLabel.text = "* Savun kendini hain kostok"
		$Invisible/ExploTimer.start()
	


func _on_SpeakButton_pressed():
	if touch == false:
		touch = true
		$Invisible/HitlerLabel.text = "*Artık konuşulacak bir şey" + "\n" + "kalmadı kiril"
		$Invisible/PlayerLabel.text = "* Konuşarak çözemezmiyiz?"
		$ExploTimer.start()

func _on_MercyButton_pressed():
	if touch == false:
		touch = true
		$Invisible/HitlerLabel.text = "*Bu bir oyun değil gel " +"\n " + "ve benimle savaş"
		$Invisible/PlayerLabel.text = "*Canını bağışlıyorum yıkıl karşımdan!"
		$ExploTimer.start()



func explo():
	$AnimationPlayer.play("ExplosionAni")


func _on_ExploTimer_timeout():
	explo()
	GameManager.bossplayer.play_fight()
	GameManager.bosshitler.play_fight()
	$Invisible/HitlerHp.show()
	$Invisible/PlayerHp.show()


func _on_DontPressButton_pressed():
	if touch == false:
		touch = true
		$Invisible/HitlerLabel.text = "*Ge.. gerçekten mi?"
		$Invisible/PlayerLabel.text = "* Aslında ben nazileri çok severim"
		$ExploTimer.start()



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Talking":
		$AnimationPlayer.play("AniPull")
	
	
