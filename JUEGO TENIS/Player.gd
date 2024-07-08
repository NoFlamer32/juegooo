extends Area2D

export (PackedScene) var scene_player_laser
export var armor = 2 setget _set_armor

# Añadir un grupo para identificar enemigos
onready var enemy_group = "enemies"

# Velocidad de movimiento
export var speed = 200

# Variable para almacenar comandos de voz
var voice_command = ""

func _set_armor(value):
	armor = value
	if armor <= 0:
		$Bu.playing = true
		queue_free()

func setup(pos):
	position = pos

func _ready():
	connect("area_entered", self, "_on_Area2D_area_entered")
	# Iniciar el timer para chequear comandos de voz
	var voice_timer = Timer.new()
	add_child(voice_timer)
	voice_timer.set_wait_time(0.5) # Chequear comandos de voz cada 0.5 segundos
	voice_timer.connect("timeout", self, "_on_VoiceTimer_timeout")
	voice_timer.start()

func _input(event):
	if event is InputEventScreenDrag:
		translate(event.relative)
	
	var pos = position
	pos.x = clamp(pos.x, 64, Utils.view_size.x - 64)
	pos.y = clamp(pos.y, 64, Utils.view_size.y - 64)
	
	position = pos

func create_laser(pos):
	var laser = scene_player_laser.instance()
	laser.position = pos
	Utils.main_node.call_deferred("add_child", laser)

func shoot():
	create_laser($Cannons/LeftCannon.global_position)

func _on_ShootTimer_timeout():
	shoot()

func _on_Area2D_area_entered(area):
	if area.is_in_group(enemy_group):
		armor -= 1
		area.queue_free() 

func _process(delta):
	var velocity = Vector2.ZERO

	if voice_command == "derecha":
		velocity.x += 1
	elif voice_command == "izquierda":
		velocity.x -= 1

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	position += velocity * speed * delta

	position.x = clamp(position.x, 64, Utils.view_size.x - 64)
	position.y = clamp(position.y, 64, Utils.view_size.y - 64)

func move_right():
	voice_command = "derecha"

func move_left():
	voice_command = "izquierda"

func set_voice_command(command):
	voice_command = command
