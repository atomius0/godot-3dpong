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
	# we should move along the x and y axis, but the meshes are all sideways, so we use z and y... TODO: FIX THIS!
	move(Vector3(0.0, -movement.y, -movement.x) * .1)
	movement = Vector2() # set to zero
#	# TODO: mouse movement
#	pass
