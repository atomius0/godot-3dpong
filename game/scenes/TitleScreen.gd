extends Control

onready var options = get_node("Options")
onready var option_count = options.get_child_count()
onready var selector = get_node("Selector")

func _ready():
	print("option_count: %s" % [option_count])
	#selector.set_global_pos(Vector2(selector.get_global_pos().x, options.get_child(0).get_global_pos().y))
	#selector.set_global_pos(Vector2(100,100))
	print("pos: %s" % [options.get_child(0).get_global_pos()])
	place_selector(0)
	
	set_process_input(true)
	pass


func _input(event):
	if (event.is_action_pressed("ui_page_up")):
		print("ui_page_up")
	pass


func place_selector(option_idx):
	selector.set_global_pos(Vector2(selector.get_global_pos().x, options.get_child(option_idx).get_global_pos().y))