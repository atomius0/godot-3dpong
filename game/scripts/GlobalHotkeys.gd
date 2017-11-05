extends Node

func _ready():
	set_process_input(true)


func _input(event):
	if (event.type == InputEvent.KEY and event.is_pressed() and not event.is_echo()):
		if (event.scancode == KEY_ESCAPE):
			get_tree().quit()
