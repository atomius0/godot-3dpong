extends Control

const ALPHA = 0.5

func _ready():
	set_hidden(true)
	set_process_input(true)


func _draw():
	draw_rect(get_viewport_rect(), Color(0.0, 0.0, 0.0, ALPHA))


func _input(event):
	if (event.is_action_pressed("start_pause")):
		toggle_pause()
		
	elif (event.is_action_pressed("menu_up") or event.is_action_pressed("menu_down")):
		print("menu_up or menu_down")


func toggle_pause():
	var tree = get_tree()
	var pause_state = not tree.is_paused()
	tree.set_pause(pause_state)
	set_hidden(not pause_state)
