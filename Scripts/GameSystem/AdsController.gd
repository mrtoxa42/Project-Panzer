extends Node




func _process(delta):
	if GameManager.inlevel == true:
		$AdMob.hide_banner()
