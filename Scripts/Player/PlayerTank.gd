extends KinematicBody2D

var hp = 10
var speed = 300
var directionx = 0
var directiony = 0
var direction = 'Right'
var velocity = Vector2(0,0)
var shootposition = Vector2(0,0)
var rotationspeed = 75
var rotationdegress = 0
var breaktimer = 0
var backbreak = false
var pressgas = false
var tankrepair = false
var crossenemy = false
var currentcroosenemy
var repaircounter = 0
var move = Vector2(0,0)
var bush = false
var gas = false
var smoke = false
var topgunrotation = 0
onready var TopGun = $TopGun
onready var CrossHair = $TopGun/CroosHair
var weapons = "Missile1" 
var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/Missile1.tscn")
var missile2 = preload("res://Scenes/Missiles/PlayerMissiles/Missile2.tscn")
var missile3 = preload("res://Scenes/Missiles/PlayerMissiles/Missile3.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var movesmoke = preload("res://Scenes/Extras/TankTools/MoveSmoke.tscn")
var track = preload("res://Scenes/Extras/TankTools/Track.tscn")
var gameend = preload("res://Scenes/Game/GameEnd.tscn")

var reload = true

func _ready():
	$TopGun/CroosHair.modulate = Color.green
	GameManager.levelcomplete = false
	GameManager.playertank = self 
	shootposition = $TopGun/ShootPosition.global_position

	$MobileController/MoveLeft.modulate.a = 0.5
	$MobileController/MoveRight.modulate.a = 0.5
func _process(delta):
	if GameManager.inlevel == false:
		GameManager.playertank = null
		queue_free()
		

	$MobileController/ChangeWeaponsButton/Missile2Label.text = str(GameManager.player_data.Missile2)
	$MobileController/ChangeWeaponsButton/Missile3Label.text = str(GameManager.player_data.Missile3)
	$MobileController/ChangeWeaponsButton/RepairKitLabel.text = str(GameManager.player_data.RepairKit)
	if weapons == "Missile2":
		$MobileController/ChangeWeaponsButton/CurrentMissileLabel.text = str(GameManager.player_data.Missile2)
	elif weapons == "Missile3":
		$MobileController/ChangeWeaponsButton/CurrentMissileLabel.text = str(GameManager.player_data.Missile3)
	else:
		$MobileController/ChangeWeaponsButton/CurrentMissileLabel.text = "∞"
	GameManager.playerweapon = weapons
	$PlayerStat/HealthBar.value = hp
	$PlayerStat/ArmorBar.value = GameManager.player_data.Armor
	

#	 (speed)
	move = global_position - CrossHair.global_position 
	

#		move_and_slide(-move * speed)


	$TopGun.rotation_degrees += rotationdegress * delta

	if GameManager.crossenemy != null:
		$TopGun.look_at(GameManager.crossenemy.global_position)
#		$TopGun/CrossHair.global_position = GameManager.crossenemy.global_position

		


	if Input.is_action_pressed("ui_up"):
		if tankrepair == false:
			$MoveSmokeTimer.start()
#			SoundController.tank_move()
			pressgas = true
			gas = true
		
	if Input.is_action_just_released("ui_up"):
		pressgas = false
		$SpeedTimer.start()
		$MoveSmokeTimer.stop()
	if Input.is_action_just_pressed("ui_down"):
		if tankrepair == false:
			gas = false 
			speed = 0
			$BreakTimer.start()
	if Input.is_action_just_released("ui_down"):
		backbreak = false
#		SoundController.tank_move_stop()
		$BreakTimer.stop()
	if Input.is_action_pressed("ui_right"):
		rotationdegress = rotationspeed
	if Input.is_action_just_released("ui_right"):
		rotationdegress = 0
	if Input.is_action_pressed("ui_left"):
		rotationdegress = -rotationspeed
	if Input.is_action_just_released("ui_left"):
		rotationdegress = 0
	if Input.is_action_just_pressed('Z'):
		shoot()

	if Input.is_action_just_pressed("1"):
		change_weapons()
		weapons = "Missile1"
		$MobileController/FireShoot/CurrentMissile.texture = load("res://Assets/Extras/Missiles/Bullet.png")
	if Input.is_action_just_pressed("2"):
		change_weapons()
		weapons = "Missile2"
		$MobileController/FireShoot/CurrentMissile.texture = load("res://icon.png")
	if Input.is_action_just_pressed("3"):
		change_weapons()
		weapons = "Missile3"
		$MobileController/FireShoot/CurrentMissile.texture = load("res://Assets/Extras/Missiles/Missile2deneme.png")
		
	if Input.is_action_just_pressed("R"):
		if GameManager.player_data.RepairKit >0:
			change_weapons()
			tank_repair()
			GameManager.player_data.RepairKit -=1
#	velocity.x = directionx
#	velocity.y = directiony

#	velocity = move_and_slide(velocity * speed * delta)


	velocity = $MobileController/Joystick.get_velo()
	if tankrepair == false:
		move_and_slide(velocity * speed)
	if velocity != Vector2.ZERO and smoke == false:
		smoke = true
		$MoveSmokeTimer.start()
	
		
func set_rotation(angle):
	rotation = angle

func shoot():
	if reload == true and tankrepair == false and bush == false: 
		$MobileController/ShootButtonAni.play("Shoot")
		if weapons == "Missile1":
			var Missile1 = missile1.instance()
			get_tree().get_root().add_child(Missile1)
			Missile1.global_position = $TopGun/ShootPosition.global_position
		elif weapons == "Missile2":
			if GameManager.player_data.Missile2 > 0:
				GameManager.player_data.Missile2 -=1
				var Missile2 = missile2.instance()
				get_tree().get_root().add_child(Missile2)
				Missile2.global_position = $TopGun/ShootPosition.global_position 
		elif weapons == "Missile3":
			if GameManager.player_data.Missile3 >0:
				GameManager.player_data.Missile3 -=1
				var Missile3 = missile3.instance()
				get_tree().get_root().add_child(Missile3)
				Missile3.global_position = $TopGun/ShootPosition.global_position
		reload = false
		var TankSmoke = tanksmoke.instance()
		get_tree().get_root().add_child(TankSmoke)
		TankSmoke.global_position = $TopGun/TopGunSprite.global_position 
		$AnimationPlayer.play("Shoot")
#		SoundController.tank_shoot1()
#		$AnimatedSprite.play("Shoot")
#		$AnimatedSprite.offset.y = -13
#		$AnimatedSprite.offset.x = 2
		$ShootTimer.start()







func _on_ShootTimer_timeout():
	reload = true


func _on_ChangeWeaponsButton_pressed():
	change_weapons()

func change_weapons():
	if $MobileController/ChangeWeaponsButton/Missile1.visible == true and $MobileController/ChangeWeaponsButton/Missile2.visible == true and $MobileController/ChangeWeaponsButton/RepairButton.visible == true :
		$MobileController/ChangeWeaponsButton/Missile1.hide()
		$MobileController/ChangeWeaponsButton/Missile2.hide()
		$MobileController/ChangeWeaponsButton/Missile3.hide()
		$MobileController/ChangeWeaponsButton/RepairButton.hide()
		$MobileController/ChangeWeaponsButton/RepairKitLabel.hide()
		$MobileController/ChangeWeaponsButton/Missile1Label.hide()
		$MobileController/ChangeWeaponsButton/Missile2Label.hide()
		$MobileController/ChangeWeaponsButton/Missile3Label.hide()
		$MobileController/ChangeWeaponsButton/TabClose.hide()
#		$MobileController/ChangeWeaponsButton/CurrentMissileLabel.hide()
	else:
		$MobileController/ChangeWeaponsButton/Missile1.show()
		$MobileController/ChangeWeaponsButton/Missile2.show()
		$MobileController/ChangeWeaponsButton/Missile3.show()
		$MobileController/ChangeWeaponsButton/RepairButton.show()
		$MobileController/ChangeWeaponsButton/Missile1Label.show()
		$MobileController/ChangeWeaponsButton/Missile2Label.show()
		$MobileController/ChangeWeaponsButton/Missile3Label.show()
		$MobileController/ChangeWeaponsButton/RepairKitLabel.show()
		$MobileController/ChangeWeaponsButton/TabClose.show()
#		$MobileController/ChangeWeaponsButton/CurrentMissileLabel.show()



func current_camera():
	$Camera2D.current = true

func _on_Missile1_pressed():
	change_weapons()
	weapons = "Missile1"
	$MobileController/FireShoot/CurrentMissile.texture = load("res://Assets/Extras/Missiles/Bullet.png")


func _on_Missile2_pressed():
	change_weapons()
	weapons = "Missile2"
	$MobileController/FireShoot/CurrentMissile.texture = load("res://icon.png")

func _on_RepairButton_pressed():
	if GameManager.player_data.RepairKit >0:
		change_weapons()
		tank_repair()
		GameManager.player_data.RepairKit -=1


func _on_MoveRight_pressed():
	GameManager.crossenemy = null
	$TopGun/CroosHair.modulate = Color.green
	$TopGun/CroosHair.scale = Vector2(2,2)
	rotationdegress = rotationspeed
	topgunrotation = TopGun.rotation
	$MobileController/MoveRight.modulate.a = 1



func _on_MoveRight_released():
	rotationdegress = 0
	$MobileController/MoveRight.modulate.a = 0.5


func _on_MoveLeft_pressed():
	$TopGun/CroosHair.modulate = Color.green
	$TopGun/CroosHair.scale = Vector2(2,2)
	GameManager.crossenemy = null
	rotationdegress = -rotationspeed
	topgunrotation = TopGun.rotation
	$MobileController/MoveLeft.modulate.a = 1


func _on_MoveLeft_released():
	rotationdegress = 0
	$MobileController/MoveLeft.modulate.a = 0.5


func _on_FireShoot_pressed():
	shoot()










func _on_SpeedTimer_timeout():
	if speed > 0.09:
		speed -= 0.03
		$SpeedTimer.start()
	else:
		speed = 0
#		SoundController.tank_move_stop()


func _on_PlayerArea_area_entered(area):
	if area.is_in_group("EnemyMissile"):
		hp -= 1
		take_damage()
	if area.is_in_group("MoveEnemy"):
		if bush == false:
			GameManager.playertank = null
			GameManager.inlevel = false
			GameManager.levelcomplete = false
			game_end()
#		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
#	if area.is_in_group("LevelEnd"):
#		GameManager.levelcomplete = true
##		if GameManager.CurrentLevel !=3:
#		get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
#		queue_free()
		
func take_damage():
	if hp <= 0:
		if GameManager.CurrentLevel == 11:
			GameManager.playedlevel.game_end()
		else:
			GameManager.playertank = null
			GameManager.levelcomplete = false
			get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")
			queue_free()


func game_end():
	var _a = get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func tank_repair():
	tankrepair = true
	$TankRepairSprite.show()
	$TankRepairTimer.start()


func _on_TankRepairTime_timeout():
	if repaircounter < 3 and tankrepair == true:
		repaircounter +=1
		hp +=1
		$TankRepairTimer.start()
	else:
		$TankRepairSprite.hide()
		tankrepair = false
		repaircounter = 0 


func _on_MoveSmokeTimer_timeout():
		var MoveSmoke = movesmoke.instance()
		get_tree().get_root().add_child(MoveSmoke)
		MoveSmoke.global_position = $Egzoz.global_position
		
		
		
		if velocity != Vector2.ZERO:
			$MoveSmokeTimer.start()
			
		else:
			smoke = false
		


func _on_Missile3_pressed():
	change_weapons()
	weapons = "Missile3"
	$MobileController/FireShoot/CurrentMissile.texture = load("res://Assets/Extras/Missiles/Missile2deneme.png")


func delete_player():
	GameManager.playertank = null
	queue_free()
func bush():
	modulate.a = 0.4
	bush = true
func exit_bush():
	modulate.a = 1
	bush = false




func _on_TabClose_pressed():
	change_weapons()





func _on_BushArea_area_entered(area):
		if area.is_in_group("Bush"):
			bush()


func _on_BushArea_area_exited(area):
		if area.is_in_group("Bush"):
			exit_bush()


func _on_ShootButtonAni_animation_finished():
	if $MobileController/ShootButtonAni.animation == "Shoot":
		$MobileController/ShootButtonAni.play("default")


func _on_TopGunSprite_animation_finished():
	$TopGun/TopGunSprite.play("Idle")



func _on_CrossArea_area_entered(area):
#	if area.is_in_group("Enemies"):
#		$TopGun/CroosHair.modulate = Color.red
#		$TopGun/CroosHair.scale = Vector2(3,3)
#		var tween = get_tree().create_tween()
#		tween.tween_property($TopGun/CroosHair,"scale",Vector2(1,1),1)
#		currentcroosenemy = area
#		crossenemy = true
	pass


func _on_CrossArea_area_exited(area):
#	if area.is_in_group("Enemies"):
#		$TopGun/CroosHair.modulate = Color.green
#		$TopGun/CroosHair.scale = Vector2(1,1)
#		currentcroosenemy = null
#		crossenemy = false
	pass

func track_timer():
	$TankTracks/TrackTimer.start()


func _on_TrackTimer_timeout():
	var Track = track.instance()
	get_tree().get_root().add_child(Track)
	Track.global_position = $TankTracks/TankTrackPos.global_position
	var Track2 = track.instance()
	get_tree().get_root().add_child(Track2)
	Track2.global_position = $TankTracks/TankTrackPos2.global_position
	if velocity != Vector2(0,0):
		$TankTracks/TrackTimer.start()
	
func cross_default():
#	$TopGun/CroosHair.global_position = $DefaultCrossPos.global_position
	$TopGun/CroosHair.modulate = Color.green
	$TopGun/CroosHair.scale = Vector2(2,2)
func cross_shoot():
	$TopGun/CroosHair.modulate = Color.red
	$TopGun/CroosHair.scale = Vector2(4,4)
	var tween = get_tree().create_tween()
	tween.tween_property($TopGun/CroosHair,"scale",Vector2(2,2),1)
	




