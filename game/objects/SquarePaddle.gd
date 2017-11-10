extends KinematicBody

#export var paddle_size = Vector2(2.0, 2.0)
onready var paddle_range = init_paddle_range()
onready var input_handler = get_node("InputHandler")

func _ready():
	add_to_group("Paddles")
	set_fixed_process(true)
	
	make_material_unique()
	

func make_material_unique():
	get_node("MeshInstance").set_material_override(preload("res://materials/paddle_alpha.tres").duplicate())
	# from: https://github.com/godotengine/godot/issues/2162#issuecomment-114866934
	# and:  https://godotengine.org/qa/7350/how-to-change-materials-in-a-single-instance
	# surface_get_material:  https://www.reddit.com/r/godot/comments/4zikue/modifying_material_properties_from_gdscript/d6wbm9q/
	#var mesh_instance = get_node("MeshInstance")
	#var material = mesh_instance.get_mesh().surface_get_material(0)
	#print(material)
	#print(mesh_instance.get_material_override())
	#mi.set_material(mi.get_material_override().duplicate())
	#mesh_instance.set_material_override(material.duplicate())


#DONE: use paddle size to determine range, otherwise paddle will partially go through the walls.
func init_paddle_range():
	var shape_extents = get_shape(0).get_extents()
	var fsg = get_node("../FieldSizeGuide")
	var bl = fsg.get_node("BottomLeft")
	var tr = fsg.get_node("TopRight")
	var paddle_range = Rect2(
		bl.get_translation().x + shape_extents.x,
		bl.get_translation().y + shape_extents.y,
		tr.get_translation().x - bl.get_translation().x - shape_extents.x*2,
		tr.get_translation().y - bl.get_translation().y - shape_extents.y*2
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
	if (pos.z < 0): # invert movement x axis for second paddle.
		movement.x = -movement.x
	pos.x += movement.x
	pos.y += movement.y
	pos = limit_paddle_range(pos)
	set_translation(pos)
