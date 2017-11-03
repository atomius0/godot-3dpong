extends KinematicBody

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)
	set_fixed_process(true)

var movement = Vector2()

func _input(event):
	# TODO: what is the input event type for mouse motion?
	if (event.type == InputEvent.MOUSE_MOTION):
		movement = movement + event.relative_pos
	pass


func _fixed_process(delta):
	print(movement)
	var rest = move(Vector3(movement.x, -movement.y, 0.0) * .1)
	if is_colliding():
		#move(rest.slide(get_collision_normal()))
		move(get_collision_normal().slide(rest))
		
	movement = Vector2() # set to zero
#	# TODO: mouse movement
#	pass
