extends KinematicBody

#export var paddle_size = Vector2(2.0, 2.0)
onready var paddle_range = init_paddle_range()
onready var input_handler = get_node("InputHandler")

func _ready():
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


func _fixed_process(delta):
	var move_to = input_handler._get_movement()
	# movement is absolute!!
	set_translation(limit_paddle_range(Vector3(move_to.x, move_to.y, get_translation().z)))
