extends Area2D

export var velocity = Vector2()
export var armor = 2 setget _set_armor

func _set_armor(value):
	armor = value
	if armor <= 0:
		$PickupSound.playing= true
		queue_free()
	

func _physics_process(delta):
	translate(velocity*delta)

	if position.y -32 >= Utils.view_size.y:
		queue_free()
