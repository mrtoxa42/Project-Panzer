extends Node


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
    print("Connection failed")

func _server_disconnected():
    print("server disconnected")

func _connected_to_server():
    print("Connected to server")
