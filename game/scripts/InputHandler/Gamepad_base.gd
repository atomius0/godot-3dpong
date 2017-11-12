extends Node

var button_sensitivity = 0.3
var stick_sensitivity = 1.0
var stick_dead_zone = 0.15

var movement = Vector2()

# override these values: ----------
var joy_device   #= 0
var button_up    #= JOY_DPAD_UP
var button_left  #= JOY_DPAD_LEFT
var button_down  #= JOY_DPAD_DOWN
var button_right #= JOY_DPAD_RIGHT
var axis_x       #= JOY_ANALOG_0_X
var axis_y       #= JOY_ANALOG_0_Y
# ---------------------------------

var move_up    = false
var move_left  = false
var move_down  = false
var move_right = false

var move_axis_x = 0.0
var move_axis_y = 0.0

func _ready():
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.JOYSTICK_BUTTON and event.device == joy_device and not event.is_echo()):
		var pressed = event.is_pressed()
		if (event.button_index == button_up):
			move_up = pressed
		elif (event.button_index == button_left):
			move_left = pressed
		elif (event.button_index == button_down):
			move_down = pressed
		elif (event.button_index == button_right):
			move_right = pressed
	
	if (event.type == InputEvent.JOYSTICK_MOTION and event.device == joy_device):
		if (event.axis == axis_x):
			move_axis_x = event.value
		elif (event.axis == axis_y):
			move_axis_y = -event.value
	
	movement = Vector2()
	if move_up:    movement.y += button_sensitivity
	if move_down:  movement.y -= button_sensitivity
	if move_left:  movement.x -= button_sensitivity
	if move_right: movement.x += button_sensitivity
	
	if (abs(move_axis_x) > stick_dead_zone):
		movement.x += ( move_axis_x - (stick_dead_zone * sign(move_axis_x)) ) * (1.0 + stick_dead_zone) * stick_sensitivity
	if (abs(move_axis_y) > stick_dead_zone):
		movement.y += ( move_axis_y - (stick_dead_zone * sign(move_axis_y)) ) * (1.0 + stick_dead_zone) * stick_sensitivity
	
	#var stick_movement = handle_dead_zone(move_axis_x, move_axis_y, stick_dead_zone)
	#movement.x += stick_movement.x * stick_sensitivity
	#movement.y += stick_movement.y * stick_sensitivity
	
	#print(movement / stick_sensitivity) # testing


func handle_dead_zone(x, y, dz):
	var v = Vector2(x, y)
	if (v.length() > dz):
		#if (abs(v.x) > dz): v.x -= (dz * sign(v.x))
		#if (abs(v.y) > dz): v.y -= (dz * sign(v.y))
		v *= 1.0 + dz
		return v
		
	return Vector2()


func _get_movement():
	return movement
