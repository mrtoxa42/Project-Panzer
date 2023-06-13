extends Node2D


var play_service


func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_service = Engine.get_singleton("GodotPlayGamesServices")
		
		play_service.initWithSavedGames(true,"test",true,true,"759723462404-pb08d5e04ulon4co35kpah0s83vu6dh6.apps.googleusercontent.com")
		
		play_service.connect("_on_sign_in_success",self,"_on_sign_in_success")
		play_service.connect("_on_sign_in_failed",self,"_on_sign_in_failed")
		play_service.connect("_on_achivement_unlocked",self,"_on_achivement_unlocked")
		play_service.connect("_on_achivement_unlocking_failed",self,"_on_achivement_unlocking_failed")
		play_service.connect("_on_achievement_incremented",self,"_on_achievement_incremented")
		play_service.connect("_on_achievementt_incrementing_failed",self,"_on_achievement_incrementing_failed")
		play_service.connect("_on_achievement_revealed",self,"_on_achievement_revealed")
		play_service.connect("_on_achievement_revealing_failed",self,"_on_achievement_revealing_failed")
		play_service.connect("_on_achievement_info_loaded",self,"_on_achievement_revealing_failed")
		play_service.connect("_on_event_submitted",self,"_on_event_submitted")
		play_service.connect("_on_event_submitted_failed",self,"_on_event_submitted_failed")
		play_service.connect("_on_achievement_info_load_failed",self,"_on_achievement_revealing_failed")
		play_service.connect("_on_achievement_info_load_failed",self,"_on_achievement_revealing_failed")
		play_service.connect("_on_events_loaded",self,"_on_events_loaded")
		play_service.connect("_on_events_empty",self,"_on_events_empty")
		play_service.connect("_on_events_loading_failed",self,"_on_events_loading_failed")
		play_service.connect("_on_player_stats_loaded",self,"_on_player_stats_loaded")
		play_service.connect("_on_player_stats_loading_failed",self,"_on_player_stats_loading_failed")
		play_service.connect("_on_player_info_loaded",self,"_on_player_info_loaded")
		play_service.connect("_on_player_info_loading_failed",self,"_on_player_info_loading_failed")
		play_service.connect("_on_game_saved_success",self,"_on_game_saved_success")
		play_service.connect("_on_game_saved_fail",self,"_on_game_saved_fail")
		play_service.connect("_on_game_load_fail",self,"_on_game_load_fail")
		play_service.connect("_on_game_load_success",self,"_on_game_load_success")
		play_service.connect("_on_create_new_snapshot",self,"_on_create_new_snapshot")

		
		
func _on_sign_in_success(userprofil):
	print(userprofil)
	
func _on_sign_in_failed(error):
	print("Error: " + str(error) )

func yeni_baslangic():
	play_service.unlockAchievement("CgkIhJ6wmI4WEAIQAg")
func gizli_cevher():
	play_service.unlockAchievement("CgkIhJ6wmI4WEAIQBA")
func ilk_gorev():
	play_service.unlockAchievement("CgkIhJ6wmI4WEAIQBw")
func emret_komutanim():
	play_service.unlockAchievement("CgkIhJ6wmI4WEAIQCA")

func _on_Button_pressed():
	play_service.signIn()


func _on_TestAchevement_pressed():
	play_service.unlockAchievement("CgkIhJ6wmI4WEAIQAg")

func _on_achievement_unlocked(id):
	print(id)
	
func _on_achivement_unlocking_failed(id):
	print(id)


func _on_IncAchevement_pressed():
	play_service.incrementAchievement("CgkIhJ6wmI4WEAIQAw",1)
	
	
func _on_achievement_incremented(id):
	print("achievement " + id + "incremented")
	
func _on_achievement_incrementing_failed(id):
	print("achievement " + id + "incremented_failed")


func _on_RevealtestAchevement_pressed():
	play_service.revealAchievement("CgkIhJ6wmI4WEAIQBA")
	
func _on_achievement_revealed(id):
	print("Achevement revealed " + id)
	
func _on_achievement_revealing_failed(id):
	print("Achevement revealed failed " + id)


func _on_showAchevemetns_pressed():
	play_service.showAchievements()


func _on_LoadAchevementInfo_pressed():
	play_service.loadAchievementInfo(false)

func _on_achievement_info_loaded(achievements):
	print(achievements)
	
func _on_achievement_info_load_failed(id):
	print("achievement load failed: " + id)


func _on_ShowLeaderBoard_pressed():
	play_service.showLeaderBoard("CgkIhJ6wmI4WEAIQBQ")


func _on_SubmitToLeaderboard_pressed():
	play_service.submitLeaderBoardScore("CgkIhJ6wmI4WEAIQBQ", 55)

func _on_leaderboard_score_submitted(id):
	print("leaderboard submitsucces: " + id)
func _on_leaderboard_score_submitting_failed(id):
	print("leaderboard submitsucees: " + id + "failed")


func _on_SubmitEvent_pressed():
	play_service.submitEvent("CgkIhJ6wmI4WEAIQBg",11)


func _on_event_submitted(id):
	print("event submitted succesfully: " + id)
	
func _on_event_submitted_failed(id):
	print("event submitted failed: " + id)

func _on_LoadEvent_pressed():
	play_service.loadEvents()
#	play_service.loadEventsByID("CgkIhJ6wmI4WEAIQBg","") # Multiple spesisific events 


func _on_events_loaded(arraylist):
	print(arraylist)
	var events = parse_json(arraylist)
	
	for event in events:
		print(event)
		
func _on_events_empty():
	print("There are no events!")
	
func _on_events_loading_failed():
	print("^Failed to load events")


func _on_GetPlayerdata_pressed():
	play_service.loadPlayerInfo()


func _on_player_info_loaded(info):
	var player = parse_json(info)
	print(player)
	var formatString = "Display Name: %s \n Name: %s \n Title: %s \n PlayerID %s \n"
	var outputString = formatString % [player.display_name, player.name,player.title,player.player_id]
	$PlayerData.text = str(outputString)
	
	
	var http_reguest = HTTPRequest.new()
	add_child(http_reguest)
	http_reguest.connect("request_completed,",self,"_on_request_complete")
	var error = http_reguest.request(player.hi_res_image_url)
	if error != OK:
		print("request failed")
	
func _on_request_complete(result, responsecode,heads,body):
	var image = Image.new()
	var error  = image.load_png_from_buffer(body)
	if error != OK:
		print("could not process data")
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	$TextureRect.texture = texture

func _on_player_info_loading_failed():
	print("player info loaded failed")
	

func _on_player_stats_loaded(stats):
	var player = parse_json(stats)
	print(player)
	var formatString = "avg sessions length: %s \n Days Since Last Player: %s \n number of Purchases %s \n Number of sessions %s"
	var outputString = formatString % [player.avg_session_length, player.days_last_played,player.purchases,player.sessions]
	$PlayerStats.text = str(outputString)

func _on_player_stats_loading_failed():
	print("player Stats failed to load")
	
func _on_GetPlayerStats_pressed():
	play_service.loadPlayerStats(false)


func _on_ShowSnapshot_pressed():
	play_service.showSavedGames("Custom Tittle",true, true,7)

func _on_create_new_snapshot(name):
	var data ={"name": "fp","health": "10"}
	play_service.saveSnapshot(name,to_json(data), "this is a test")
func _on_GetSnapShot_pressed():
	play_service.loadSnapshot("test")
	
func _on_game_load_success(data):
	var savedData = parse_json(data)
	print(data)
	var formatString = "Name: %s \n Health: %s"
	var outputString = formatString % [data.name,data.health]
	$SaveData.text = str(outputString)
	
func _on_game_load_fail():
	print("load game failed")
	 
func _on_SaveSnapShoot_pressed():
	var data ={"name": "fp","health": "10"}
	play_service.saveSnapshot("test",to_json(data), "this is a test")
	
func _on_game_saved_success():
	print("Succesfully Saved Game")
	
func _on_game_saved_fail():
	print("Failed to save game")
