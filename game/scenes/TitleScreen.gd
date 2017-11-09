extends Control

onready var options_node = get_node("Options")
onready var option_count = options_node.get_child_count()
onready var cursor = get_node("Cursor")

var cursor_pos = 0 # currently selected menu option

enum Option {
	#GAME_MODE,
	PLAYER1_INPUT,
	PLAYER2_INPUT,
	START_GAME
}

enum InputHandler {
	MOUSE,
	KEYBOARD_WASD,
	KEYBOARD_ARROWS,
	GAMEPAD1_LEFT_STICK,
	GAMEPAD1_RIGHT_STICK,
	GAMEPAD2_LEFT_STICK,
	GAMEPAD2_RIGHT_STICK,
	CPU_WEAK,
	CPU_MEDIUM,
	CPU_STRONG,
	CPU_PERFECT
}

const INPUT_HANDLER_NAMES = [
	"Mouse",
	"WASD Keys",
	"Arrow Keys",
	"Gamepad 1 Left Stick",
	"Gamepad 1 Right Stick",
	"Gamepad 2 Left Stick",
	"Gamepad 2 Right Stick",
	"CPU - Weak",
	"CPU - Medium",
	"CPU - Strong",
	"CPU - Perfect"
]

# Options: ----------
var player1_input = InputHandler.MOUSE
var player2_input = InputHandler.CPU_PERFECT # TODO: change to CPU_WEAK once implemented.
# -------------------

func _ready():
	place_cursor(0)
	set_option(Option.PLAYER1_INPUT, player1_input)
	set_option(Option.PLAYER2_INPUT, player2_input)
	
	set_process_input(true)
	pass


func _input(event):
	if (event.is_action_pressed("menu_up")):
		move_cursor(-1)
		
	elif (event.is_action_pressed("menu_down")):
		move_cursor(1)
		
	elif (event.is_action_pressed("menu_left")):
		change_option(cursor_pos, -1)
		print("menu_left")
		
	elif (event.is_action_pressed("menu_right")):
		change_option(cursor_pos, 1)
		print("menu_right")
		
	elif (event.is_action_pressed("menu_accept")):
		print("menu_accept")


func change_option(option_idx, direction):
	# changes the option relative to the current option
	print("change_option: %s, %s" % [option_idx, direction])
	
	#var is_changeable = false
	var max_option_id
	if (option_idx == Option.PLAYER1_INPUT):
		#is_changeable = true
		max_option_id = InputHandler.CPU_PERFECT
		
	elif (option_idx == Option.PLAYER2_INPUT):
		#is_changeable = true
		max_option_id = InputHandler.CPU_PERFECT
	
	var new_option_id = get_option_id(option_idx) + direction
	new_option_id = int(clamp(new_option_id, 0, max_option_id))
	set_option(option_idx, new_option_id)


func get_option_id(option_idx):
	if (option_idx == Option.PLAYER1_INPUT):
		return player1_input
	elif (option_idx == Option.PLAYER2_INPUT):
		return player2_input
		


func set_option(option_idx, option_id):
	if (option_idx == Option.PLAYER1_INPUT):
		player1_input = option_id
		options_node.get_child(Option.PLAYER1_INPUT).get_node("Option").set_text(INPUT_HANDLER_NAMES[option_id])
	elif (option_idx == Option.PLAYER2_INPUT):
		player2_input = option_id
		options_node.get_child(Option.PLAYER2_INPUT).get_node("Option").set_text(INPUT_HANDLER_NAMES[option_id])
	pass


func move_cursor(direction):
	cursor_pos = int(fposmod(cursor_pos + direction, option_count))
	place_cursor(cursor_pos)
	

func place_cursor(option_idx):
	# so we can call this method to place the cursor on a specific option without having to set cursor_pos manually:
	cursor_pos = option_idx
	cursor.set_global_pos(Vector2(cursor.get_global_pos().x, options_node.get_child(option_idx).get_global_pos().y))
