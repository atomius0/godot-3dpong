extends Control

onready var options = get_node("Options")
onready var option_count = options.get_child_count()
onready var selector = get_node("Selector")

func _ready():
	print("option_count: %s" % [option_count])
	selector.set_global_pos(Vector2(selector.get_global_pos().x, options.get_child(0).get_global_pos().y))
	#selector.set_global_pos(Vector2(100,100))
	print("pos: %s" % [options.get_child(0).get_global_pos()])
	pass
