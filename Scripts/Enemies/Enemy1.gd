extends KinematicBody2D


var speed = 1000
var hp = 3
var playerarea = false
var playershoot = false
var targetfriend = null
var friend = false
var velocity = Vector2.ZERO
var missile1 = preload("res://Scenes/Missiles/EnemyMissiles/EnemyMissile1.tscn")
var missile2 = preload("res://Scenes/Missiles/EnemyMissiles/EnemyFriendMissile1.tscn")
var tanksmoke = preload("res://Scenes/Extras/TankTools/TanksSmoke.tscn")
var explosion = preload("res://Scenes/Extras/Explosions/TankExplosion1.tscn")
var track = preload("res://Scenes/Extras/TankTools/Track.tscn")



func _ready():
	$ProgressBar.hide()
func _process(_delta):
	if GameManager.inlevel == false:
		queue_free()
	$ProgressBar.value = hp
	if playerarea == true and playershoot == false and friend == false	:
		if GameManager.playertank != null:
			velocity = GameManager.playertank.global_position - global_position
			velocity = move_and_slide(velocity)
	else:
		velocity = Vector2.ZERO
	if playerarea == true and GameManager.playertank != null and targetfriend == null:
		look_at(GameManager.playertank.global_position)


func _on_EnemyDetectArea_area_entered(area):
	if area.is_in_group("Player"):
		if friend == false:
			$DetectTimer.start()
			playerarea = true
			$ShootTimer.start()
			$TankTracks/TrackTimer.start()
	if area.name == "RadarBoundaryArea" or area.is_in_group("Missile3Radar"):
		if GameManager.targetenemy == null:
			GameManager.targetenemy = self

	if area.is_in_group("Friend"):
		look_at(area.global_position)
		velocity = Vector2(0,0)
		friend_tank()
		playershoot = false
		
		targetfriend = area
		friend = true
		$ShootTimer.start()

func friend_tank():
	pass

func shoot():
	var TankSmoke = tanksmoke.instance()
	get_tree().get_root().add_child(TankSmoke)
	TankSmoke.global_position = $ShootPosition.global_position
	if friend == true:
		var Missile = missile2.instance()
		get_tree().get_root().add_child(Missile)
		Missile.global_position = $ShootPosition.global_position
		$ShootTimer.start()
	elif playerarea == true:
		var Missile2 = missile1.instance()
		get_tree().get_root().add_child(Missile2)
		Missile2.global_position = $ShootPosition.global_position
		$ShootTimer.start()

func _on_EnemyDetectArea_area_exited(area):
	if area.is_in_group("Player"):
		if friend == false:
			playershoot = false
			$TankTracks/TrackTimer
	if area == targetfriend:
		targetfriend = null
		friend = false

func _on_ShootTimer_timeout():
	if playershoot == true:
		shoot()
		$ShootTimer.start()
	if friend == true:
		shoot()
		$ShootTimer.start()

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle")


func take_damage():
	playerarea = true
	$ProgressBar.show()
	if hp > 1:
		hp -=1
	else:
		explosion()
func explosion():
	if GameManager.crossenemy == self:
		GameManager.crossenemy = null
		GameManager.playertank.cross_default()
	if GameManager.CurrentLevel == 8:
		GameManager.playedlevel.death_enemy()
	var Explosion = explosion.instance()
	get_tree().get_root().add_child(Explosion)
	Explosion.global_position = global_position
	queue_free()


func _on_EnemyArea_area_entered(area):
	if area.is_in_group("Missile1"):
		take_damage()
	if area.is_in_group("Missile2"):
		hp -=2
		take_damage()
	if area.is_in_group("Missile3"):
		hp -=3
		take_damage()


func _on_DetectTimer_timeout():
		playershoot = true


func _on_CrossButton_pressed():
	if GameManager.crossfixed == true:
		GameManager.crossenemy = self
		GameManager.playertank.cross_shoot()


func _on_TrackTimer_timeout():
	var Track = track.instance()
	get_tree().get_root().add_child(Track)
	Track.global_position = $TankTracks/TankTrackPos.global_position
	var Track2 = track.instance()
	get_tree().get_root().add_child(Track2)
	Track2.global_position = $TankTracks/TankTrackPos2.global_position
	if velocity != Vector2(0,0):
		$TankTracks/TrackTimer.start()
