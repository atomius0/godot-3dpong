extends Control

const ALPHA = 0.5
const TITLE_SCENE = "res://scenes/TitleScreen.tscn"

onready var cursor = get_node("Menu/Cursor")
onready var options_node = get_node("Menu/Options")

var cursor_pos = 0 # currently selected menu option

func _ready():
	set_hidden(true)
	set_process_input(true)


func _draw():
	draw_rect(get_viewport_rect(), Color(0.0, 0.0, 0.0, ALPHA))


func _input(event):
	if (event.is_action_pressed("start_pause")):
		toggle_pause()
		
	elif (not is_hidden()): # if pause menu is shown:
		if (event.is_action_pressed("menu_up") or event.is_action_pressed("menu_down")):
			#print("menu_up or menu_down")
			cursor_pos = 1 - cursor_pos # toggle cursor position between 0 and 1.
			place_cursor(cursor_pos)
			
		elif (event.is_action_pressed("menu_accept")):
			accept_option(cursor_pos)


func place_cursor(option_idx):
	cursor.set_global_pos(Vector2(cursor.get_global_pos().x, options_node.get_child(option_idx).get_global_pos().y))


enum {OPTION_CONTINUE, OPTION_QUIT}

func accept_option(option_idx):
	if (option_idx == OPTION_CONTINUE):
		toggle_pause()
	elif (option_idx == OPTION_QUIT):
		toggle_pause() # unpause, otherwise the title screen will hang.
		get_tree().change_scene(TITLE_SCENE)


func toggle_pause():
	var tree = get_tree()
	var pause_state = not tree.is_paused()
	tree.set_pause(pause_state)
	set_hidden(not pause_state)
