extends Position2D


var rock = preload("res://Scenes/Extras/Obstacle/Rock.tscn")



var rng = RandomNumberGenerator.new()
var rngy = RandomNumberGenerator.new()






func _on_SpawnTimer_timeout():
	rng.randomize()
	rngy.randomize()
	var r = rng.randi_range(1,1)
	var y = rngy.randf_range(10,500)
	if r == 1 :
		var Rock = rock.instance()
		get_tree().get_root().add_child(Rock)
		Rock.global_position = global_position - Vector2(0,y)
		Rock.z_index = -1
