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
	move_to.x = clamp(move_to.x, pr.pos.x, pr.end.x)
	move_to.y = clamp(move_to.y, pr.pos.y, pr.end.y)
	return move_to


func _fixed_process(delta):
	var movement = input_handler._get_movement()
	var pos = get_translation()
	pos.x += movement.x
	pos.y += movement.y
	pos = limit_paddle_range(pos)
	set_translation(pos)
