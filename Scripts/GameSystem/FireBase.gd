extends Node

# Firebase eklentisini içe aktarın
var firebase = Engine.get_singleton("GodotFire")

# Firebase yapılandırmasını yapın

func _ready():
	firebase_config()
func firebase_config():
	firebase.configure({
		"google-services-file-path": "res://google-services.json"
	})

	# FCM bildirimi göndermek için bir işlevi çağırın
	var message = {
		"to": "<hedef_cihaz_tokenı>",
		"notification": {
			"title": "Bildirim başlığı",
			"body": "Bildirim içeriği"
		}
	}

	firebase.fcm_send_message(message)
