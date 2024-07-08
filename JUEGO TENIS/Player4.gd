extends Area2D

export (PackedScene) var scene_player_laser
export var armor = 2 setget _set_armor

func _set_armor(value):
	armor = value
	if armor <= 0:
		$Bu.playing= true
		queue_free()

func setup(pos):
	position=pos


#
#func _ready():
#	print(Utils.view_size)

func _input(event):
	if event is InputEventScreenDrag:
		#position= event.position
		translate(event.relative)
	
	var pos = position
	pos.x = clamp(pos.x, 64, Utils.view_size.x -64)
	pos.y = clamp(pos.y, 64, Utils.view_size.y -64)
	
	position=pos

func create_laser(pos):
	var laser= scene_player_laser.instance()
	laser.position = pos
	Utils.main_node.call_deferred("add_child", laser)
	
func shoot():
	create_laser($Cannons/LeftCannon.global_position)
	

func _on_ShootTimer_timeout():
	shoot() # Replace with function body.
