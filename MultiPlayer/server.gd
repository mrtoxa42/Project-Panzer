extends Node

var player = preload("res://Scenes/Player/PlayerTank.tscn")
var otherplayer = preload("res://MultiPlayer/OtherPlayer.tscn")
func _ready():
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	get_tree().connect("connected_to_server",self,"server_disconnected")
	get_tree().connect("connection_failed",self,"connection_failed")


func join_server():
	var client = NetworkedMultiplayerENet.new()
	var err = client.create_client("127.0.0.1",4242)
	if err != OK:
		print("unable_to_connect")
		return
	get_tree().network_peer = client


func connection_failed():
	get_node("root/Lobby/Button").disabled = false
	print("Connection failed")

func _server_disconnected():
	get_node("root/Lobby").show()
	print("server disconnected")

func _connected_to_server():
	if has_node("root/Lobby"):
		get_node("root/Lobby").hide()
	print("Connected to server")

remote func instance_player(id,location):
	var p = player if get_tree().get_network_unique_id() == id else otherplayer
	var player_instance = Global.instance_node(p, Nodes, location)
	player_instance.name = str(id)
	if get_tree().get_network_unique_id() == id:
		for i in get_tree().get_network_connected_peers():
			if i != 1:
				instance_player(i,location)
