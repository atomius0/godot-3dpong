extends Node

var sensitivity = 0.3
var movement = Vector2()

# override these values: ----------
var scancode_up    #= KEY_W
var scancode_left  #= KEY_A
var scancode_down  #= KEY_S
var scancode_right #= KEY_D
# ---------------------------------

var move_up    = false
var move_left  = false
var move_down  = false
var move_right = false

func _ready():
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.KEY and not event.is_echo()):
		var pressed = event.is_pressed()
		if (event.scancode == scancode_up):
			move_up = pressed
		elif (event.scancode == scancode_left):
			move_left = pressed
		elif (event.scancode == scancode_down):
			move_down = pressed
		elif (event.scancode == scancode_right):
			move_right = pressed
	
	movement = Vector2()
	if move_up:    movement.y += sensitivity
	if move_down:  movement.y -= sensitivity
	if move_left:  movement.x -= sensitivity
	if move_right: movement.x += sensitivity


func _get_movement():
	return movement
