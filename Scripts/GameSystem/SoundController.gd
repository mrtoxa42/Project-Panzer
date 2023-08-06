extends Node



func UIClickSound():
	if GameManager.game_data.sfx == true:
		$UIClickSound.play()
