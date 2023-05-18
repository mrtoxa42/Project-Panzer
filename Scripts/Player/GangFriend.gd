extends KinematicBody2D


var hp =20
var damage = 1
var speed = 20000
var enemy = false
var targetenemy = null
var movetarget = null
var velocity = Vector2.ZERO
var playerarea = false
var movetimer = false
var bush = false

var track = preload("res://Scenes/Extras/TankTools/Track.tscn")
var missile1 = preload("res://Scenes/Missiles/PlayerMissiles/FriendMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")
var movesmoke = preload("res://Scenes/Extras/TankTools/MoveSmoke.tscn")

func _process(delta):
	if targetenemy != null:
		look_at(targetenemy.global_position)
	if GameManager.inlevel == false:
		queue_free()
	if playerarea == false and targetenemy == null and movetarget == null:
		if GameManager.playertank != null:
			var velocity = Vector2(GameManager.playertank.global_position - global_position).normalized()
			velocity = move_and_slide(velocity * speed * delta)
			look_at(GameManager.playertank.global_position)
			$TankTracks/TrackTimer.start()
	else:
		velocity = Vector2.ZERO
	if playerarea == true and GameManager.playertank != null and targetenemy == null:
		look_at(GameManager.playertank.global_position)

	$ProgressBar.value = hp
	
	if targetenemy == null and movetarget != null:
		velocity = Vector2(movetarget.global_position - global_position).normalized()
		move_and_slide(velocity * speed * delta)
		look_at(movetarget.global_position)


func _on_DetectArea_area_entered(area):
	if area.is_in_group("Enemy"):
		if targetenemy == null:
			targetenemy = area
			enemy = true
			$ShootTimer.start()
	if area.name == "PlayerArea":
		$MoveTimer.start()
		$TankTracks/TrackTimer.start()



func _on_DetectArea_area_exited(area):
	if area.is_in_group("Enemy"):
		if targetenemy == area:
			enemy = false
			targetenemy = null
		
	if area.name == "PlayerArea":
		playerarea = false
		$TankTracks/TrackTimer.start()
func shoot():
	if enemy == true:
		var Missile1 = missile1.instance()
		get_tree().get_root().add_child(Missile1)
		$AnimatedSprite.play("Fire")
		Missile1.global_position = $ShootPosition.global_position
		var Smoke = tanksmoke.instance()
		get_tree().get_root().add_child(Smoke)
		Smoke.global_position = $ShootPosition.global_position
		$ShootTimer.start()
	


func _on_ShootTimer_timeout():
	shoot()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Fire":
		$AnimatedSprite.play("default")



func take_damage():
	if GameManager.CurrentLevel == 9:
		print("a")
		GameManager.playedlevel.death_friend()
		_explosion()
		
	else:
		if hp > 1:
				hp -=1
		else:
			_explosion()

func _explosion():
	var Explosion = explosion.instance()
	get_tree().get_root().add_child(Explosion)
	Explosion.global_position = global_position
	queue_free()
	


func _on_FriendArea_area_entered(area):
	if area.is_in_group("EnemyMissile"):
		take_damage()
	if area.is_in_group("MoveEnemy"):
		if bush == false:
			GameManager.levelcomplete = false
			GameManager.inlevel = false
			get_tree().change_scene("res://Scenes/Game/GameEnd.tscn")

func _on_MoveSmokeTimer_timeout():
	if playerarea == false:
		var MoveSmoke = movesmoke.instance()
		get_tree().get_root().add_child(MoveSmoke)
		MoveSmoke.global_position = $Egzoz.global_position


func _on_MoveTimer_timeout():
	playerarea = true


func _on_FriendBushArea_area_entered(area):
	if area.is_in_group("Bush"):
		bush()



func _on_FriendBushArea_area_exited(area):
	if area.is_in_group("Bush"):
		exit_bush()
		
func bush():
	modulate.a = 0.4
	bush = true
func exit_bush():
	modulate.a = 1
	bush = false



func _on_GangArea_area_entered(area):
	if area.is_in_group("Enemy"):
		if movetarget == null:
			movetarget = area
		


func _on_GangArea_area_exited(area):
	if area.is_in_group("Enemy"):
		if movetarget == area:
			movetarget = null
			$AnimationPlayer.play("GangAni")


func _on_TrackTimer_timeout():
	var Track = track.instance()
	get_tree().get_root().add_child(Track)
	Track.global_position = $TankTracks/TankTrackPos.global_position
	var Track2 = track.instance()
	get_tree().get_root().add_child(Track2)
	Track2.global_position = $TankTracks/TankTrackPos2.global_position
	if velocity != Vector2(0,0):
		$TankTracks/TrackTimer.start()
