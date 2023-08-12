extends ParallaxBackground

var speed = 200


func _process(delta):
	if GameManager.inlevel == true:
		$ParallaxLayer.motion_offset.x -= speed * delta
# "target" is the Canvas item which material contains the shader.

