extends Node

var save_path = "user://game_data.json"
var save_path2 = "user://player_data.tres"
# Sahnelerin tutuduğu değişkenler
var playertank
var gui 
var crosshair
var playedlevel 
var bossplayer
var bosshitler 
var look 
var joystick
var TrackRotation = 0
var crossenemy


# Oyun için değişkenler
var CurrentLevel = 1
var levelend 
var playerweapon = "Missile1"
var targetenemy = null
var levelcomplete = false
var gathermedal = 0
var gathermedal2 = false
var inlevel = true
var level4move = false
var crossfixed = true
var level10



#Reklam değişkenleri
var hangarinterstitialcounter = 0
var gameendinterstitialcounter = 0

#Levellere özel değişkenler
var level2station


#Kaydedilecek oyun değişkenleri
var game_data = {
	nextlevel =3,
	currentlevel = 1,
	firstopen = true,
	Language = "Turkish",
	musicvalue = -40,
	sfxvalue = -40,
	music = true,
	sfx = true
}

var player_data = {
	Medal1 = 100,
	Medal2 = 0,
	Missile2 = 100,
	Missile3 = 10,
	RepairKit = 5,
	Armor = 100,
}


func _save(): 
	var file = File.new()
	file.open(save_path, File.WRITE)
	file.store_var(game_data)
	file.close()
	
	var file2 = File.new()
	file2.open(save_path2,File.WRITE)
	file2.store_var(player_data)
	file2.close()
func _load():
	var file = File.new()
	if file.file_exists(save_path):
		file.open(save_path, File.READ)
		game_data = file.get_var()
		file.close()
		
	var file2 = File.new()
	if file2.file_exists(save_path2):
		file2.open(save_path2, File.READ)
		player_data = file2.get_var()
		file2.close()

func delete_save():
	var dir = Directory.new()
	dir.remove(save_path)
	dir.remove(save_path2)


func _ready():
#	_load()
	pass
	
