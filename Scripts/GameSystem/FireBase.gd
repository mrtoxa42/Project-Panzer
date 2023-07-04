extends Node

var firebase = null

func _ready():
	if Engine.has_singleton("Firebase"):
		firebase  = Engine.get_singleton("Firebase")
		print("Load Firebase")
		if firebase:
			firebase.init(get_instance_id())
		firebase.cloudmessaging_subscribe_to_topic("topicName")
