extends Node

var sensitivity = 0.3
var movement = Vector2()

func _ready():
	set_process_input(true)

var move_up    = false
var move_down  = false
var move_left  = false
var move_right = false

func _input(event):
	if (event.type == InputEvent.KEY and not event.is_echo()):
		var pressed = event.is_pressed()
		if (event.scancode == KEY_W):
			move_up = pressed
		elif (event.scancode == KEY_A):
			move_left = pressed
		elif (event.scancode == KEY_S):
			move_down = pressed
		elif (event.scancode == KEY_D):
			move_right = pressed
	
	movement = Vector2()
	if move_up:    movement.y += sensitivity
	if move_down:  movement.y -= sensitivity
	if move_left:  movement.x -= sensitivity
	if move_right: movement.x += sensitivity
	#movement = event.relative_pos * Vector2(1.0, -1.0) * sensitivity


func _get_movement():
	return movement
