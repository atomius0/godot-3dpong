extends Node

func _ready():
	set_process_input(true)


func _input(event):
	if (event.type == InputEvent.KEY and event.is_pressed() and not event.is_echo()):
		#if (event.scancode == KEY_ESCAPE or (event.alt == true and event.scancode == KEY_F4)):
		#if (event.scancode == KEY_ESCAPE):
		#	get_tree().quit()
		
		if (event.scancode == KEY_F11): # toggle fullscreen
			OS.set_window_fullscreen(!OS.is_window_fullscreen())
