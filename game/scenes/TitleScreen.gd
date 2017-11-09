extends Control

onready var options = get_node("Options")
onready var option_count = options.get_child_count()
onready var cursor = get_node("Cursor")

var cursor_pos = 0 # currently selected menu option

func _ready():
	#print("option_count: %s" % [option_count])
	#cursor.set_global_pos(Vector2(cursor.get_global_pos().x, options.get_child(0).get_global_pos().y))
	#cursor.set_global_pos(Vector2(100,100))
	#print("pos: %s" % [options.get_child(0).get_global_pos()])
	place_cursor(0)
	
	set_process_input(true)
	pass


func _input(event):
	if (event.is_action_pressed("menu_up")):
		move_cursor(-1)
		
	elif (event.is_action_pressed("menu_down")):
		move_cursor(1)
		
	elif (event.is_action_pressed("menu_left")):
		print("menu_left")
		
	elif (event.is_action_pressed("menu_right")):
		print("menu_right")
		
	elif (event.is_action_pressed("menu_accept")):
		print("menu_accept")


func move_cursor(direction):
	cursor_pos = int(fposmod(cursor_pos + direction, option_count))
	place_cursor(cursor_pos)
	

func place_cursor(option_idx):
	# so we can call this method to place the cursor on a specific option without having to set cursor_pos manually:
	cursor_pos = option_idx
	cursor.set_global_pos(Vector2(cursor.get_global_pos().x, options.get_child(option_idx).get_global_pos().y))
