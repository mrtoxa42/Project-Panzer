extends Node2D


var play_service


func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_service = Engine.get_singleton("GodotPlayGamesServices")
		
		play_service.init(true,true,true,"759723462404-pb08d5e04ulon4co35kpah0s83vu6dh6.apps.googleusercontent.com")
		
		play_service.connect("_on_sign_in_success",self,"_on_sign_in_success")
		
		
func _on_sign_in_success(userprofil):
	pass
