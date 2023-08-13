extends Node2D


var touch = false


func _process(delta):
	$HitlerHp.value = GameManager.bosshitler.hp
	$PlayerHp.value = GameManager.bossplayer.hp
	


func _on_AttackButton_pressed():
	if touch == false:
		touch = true
		$HitlerLabel.text = "* Bende bunu istiyordum"
		$PlayerLabel.text = "* Savun kendini hain kostok"
		$ExploTimer.start()
	


func _on_SpeakButton_pressed():
	if touch == false:
		touch = true
		$HitlerLabel.text = "*Artık konuşulacak bir şey" + "\n" + "kalmadı kiril"
		$PlayerLabel.text = "* Konuşarak çözemezmiyiz?"
		$ExploTimer.start()

func _on_MercyButton_pressed():
	if touch == false:
		touch = true
		$HitlerLabel.text = "*Bu bir oyun değil gel " +"\n " + "ve benimle savaş"
		$PlayerLabel.text = "*Canını bağışlıyorum yıkıl karşımdan!"
		$ExploTimer.start()



func explo():
	$AnimationPlayer.play("ExplosionAni")


func _on_ExploTimer_timeout():
	explo()
	GameManager.bossplayer.play_fight()
	GameManager.bosshitler.play_fight()
	$HitlerHp.show()
	$PlayerHp.show()


func _on_DontPressButton_pressed():
	if touch == false:
		touch = true
		$HitlerLabel.text = "*Ge.. gerçekten mi?"
		$PlayerLabel.text = "* Aslında ben nazileri çok severim"
		$ExploTimer.start()



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Talking":
		$AnimationPlayer.play("ExplosionAni")
	
	
