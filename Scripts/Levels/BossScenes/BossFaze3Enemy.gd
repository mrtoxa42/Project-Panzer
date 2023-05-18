extends Area2D


var missile = preload("res://Scenes/Missiles/EnemyMissiles/BossMissile/BossMissile1.tscn")




func _ready():
	var tween = get_tree().create_tween()
	
	tween.tween_property(self,"position",Vector2(0,300),1)
