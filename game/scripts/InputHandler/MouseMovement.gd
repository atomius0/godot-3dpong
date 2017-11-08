extends Node

var sensitivity = 0.15
var movement = Vector2()

func _ready():
	set_process_input(true)
	# there is a bug, that apparently makes it impossible to hide the mouse when it is captured...
	# https://github.com/godotengine/godot/issues/5051
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED | Input.MOUSE_MODE_HIDDEN)
	# these two overwrite each other:
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# so let's just hide the mouse and "capture" it via code (in _input):
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _exit_tree():
	# disable mouse capture when this node gets deleted.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


var skip_next_mouse_motion = false

func _input(event):
	if (event.type == InputEvent.MOUSE_MOTION):
		# DIRTY HACK: see comment block below!
		if (skip_next_mouse_motion):
			skip_next_mouse_motion = false
			return
		
		# handle the motion event normally:
		movement = event.relative_pos * Vector2(1.0, -1.0) * sensitivity
		
		# DIRTY HACK: we use Input.warp_mouse_pos() to "capture" the mouse cursor manually,
		# since the regular way does not work because of the bug described in the comments of func _ready().
		# but this causes a MOUSE_MOTION event to be sent, which we don't want, since that would cause an infinite loop.
		# (user moves mouse -> motion event gets handled -> we warp it back -> causes motion event -> we warp it back -> etc...)
		# so we will ignore the next mouse motion event by setting "skip_next_mouse_motion" to true.
		# when the next mouse motion event gets handled, we check if "skip_next_mouse_motion" is true.
		#if it is, we set it to false and return, before doing anything with the event.
		skip_next_mouse_motion = true
		Input.warp_mouse_pos(get_viewport().get_rect().size * 0.5)
		# NOTE: there is still an issue with this workaround:
		# if the user moves the mouse too quickly, it will leave the window before we can set it back.
		# so controlling the paddle won't work until the user moves the cursor back inside the game's window.
		# POTENTIAL WORKAROUND (TODO): enable set_process() and warp the mouse on every frame inside func _process().
		# remember that we will still need to set "skip_next_mouse_motion" to true!


func _get_movement():
	# return movement and reset it.
	var r = movement
	movement = Vector2()
	return r
