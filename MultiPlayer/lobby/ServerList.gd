extends Node2D

var death_mach = true
var flag_war = true


func _on_Mod1_pressed():
	filter_mode()


func _on_Mod2_pressed():
	filter_mode()


func filter_mode():
	if $Mod1.pressed == true:
		flag_war = true
	else:
		flag_war = false
	if $Mod2.pressed == true:
		death_mach = true
	else:
		death_mach = false
		
	if death_mach and flag_war:
		$FlagSv.show()
		$DeathSv.show()
	elif death_mach == true and flag_war == false:
		$DeathSv.show()
		$FlagSv.hide()
	elif death_mach == false and flag_war == true:
		$DeathSv.hide()
		$FlagSv.show()
	else:
		$DeathSv.hide()
		$FlagSv.hide()


func _on_Sv1JoinButton_pressed():
	get_tree().change_scene("res://MultiPlayer/world/Sv2.tscn")
