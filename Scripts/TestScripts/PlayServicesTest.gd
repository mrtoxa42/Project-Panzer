extends Node2D


var play_service


func _ready():
	if Engine.has_singleton("GodotPlayGamesServices"):
		play_service = Engine.get_singleton("GodotPlayGamesServices")
		
		play_service.init(true,true,true,"759723462404-pb08d5e04ulon4co35kpah0s83vu6dh6.apps.googleusercontent.com")
		
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

		
		
func _on_sign_in_success(userprofil):
	print(userprofil)
	
func _on_sign_in_failed(error):
	print("Error: " + str(error) )


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
