extends Node2D

var server = TCP_Server.new()

func _ready():
	server.listen(9999)
	set_process(true)

func _process(delta):
	if server.is_connection_available():
		var client = server.take_connection()
		var command = client.get_utf8_string()
		if command != "":
			get_parent().call("set_voice_command", command)
		client.close()
