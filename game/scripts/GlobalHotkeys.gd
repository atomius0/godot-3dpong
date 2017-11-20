extends Node

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS) # without this, hotkeys won't work when paused!
	set_process_input(true)


func _input(event):
	if (event.type == InputEvent.KEY and event.is_pressed() and not event.is_echo()):
		#if (event.scancode == KEY_ESCAPE or (event.alt == true and event.scancode == KEY_F4)):
		#if (event.scancode == KEY_ESCAPE):
		#	get_tree().quit()
		
		if (event.scancode == KEY_F11): # toggle fullscreen
			OS.set_window_fullscreen(!OS.is_window_fullscreen())
		
		elif (event.scancode == KEY_F2): # take a screenshot (KEY_PRINT does not cause an InputEvent...)
			print("print pressed")
			#print(OS.get_data_dir())
			take_screenshot("./screenshot.png")


func take_screenshot(filename):
	get_viewport().queue_screen_capture()
	var capture = null
	while (capture == null or capture.empty()):
		yield(get_tree(), "idle_frame")
		capture = get_viewport().get_screen_capture()
	
	capture.save_png(filename)