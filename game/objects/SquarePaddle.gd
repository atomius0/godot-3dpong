extends KinematicBody

#export var paddle_size = Vector2(2.0, 2.0)
onready var paddle_range = init_paddle_range()

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)
	set_fixed_process(true)

#TODO: use paddle size to determine range, otherwise paddle will partially go through the walls.
func init_paddle_range():
	var fsg = get_node("../FieldSizeGuide")
	var bl = fsg.get_node("BottomLeft")
	var tr = fsg.get_node("TopRight")
	var paddle_range = Rect2(
		bl.get_translation().x,
		bl.get_translation().y,
		tr.get_translation().x - bl.get_translation().x,
		tr.get_translation().y - bl.get_translation().y
	)
	return paddle_range

func limit_paddle_range(move_to):
	var pr = paddle_range # shorthand
	var move_to_v2 = Vector2(clamp(move_to.x, pr.pos.x, pr.end.x), clamp(move_to.y, pr.pos.y, pr.end.y))
	return Vector3(move_to_v2.x, move_to_v2.y, move_to.z)


var movement = Vector2()

func _input(event):
	# TODO: what is the input event type for mouse motion?
	if (event.type == InputEvent.MOUSE_MOTION):
		movement = movement + event.relative_pos
	pass


func _fixed_process(delta):
	# movement will be absolute!!
	#print(movement)
	set_translation(limit_paddle_range(Vector3(get_translation().x + movement.x, get_translation().y - movement.y, get_translation().z)))
	#var rest = move(Vector3(movement.x, -movement.y, 0.0) * .1)
	#if is_colliding():
	#	#move(rest.slide(get_collision_normal()))
	#	move(get_collision_normal().slide(rest))
	
	movement = Vector2() # set to zero
#	# TODO: mouse movement
#	pass
