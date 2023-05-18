extends Position2D



var gangenemy = preload("res://Scenes/Enemies/GangEnemy.tscn")
var rng = RandomNumberGenerator.new()
var r = 0


func _ready():
	if GameManager.CurrentLevel == 11:
		$StartTimer.wait_time = 1
	


func _on_SpawnTimer_timeout():
	rng.randomize()
	r = rng.randi_range(0,2)
	if r == 1:
		pass
	var GangEnemy = gangenemy.instance()
	get_tree().get_root().add_child(GangEnemy)
	GangEnemy.global_position = global_position

func _on_StartTimer_timeout():
	$SpawnTimer.start()
