extends Node

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

const INPUT_HANDLER_SCRIPTS = [
	"res://scripts/InputHandler/MouseMovement.gd",
	"res://scripts/InputHandler/Keyboard_wasd.gd",
	"res://scripts/InputHandler/Keyboard_arrow_keys.gd",
	"res://scripts/InputHandler/Gamepad1_left_stick.gd",
	"res://scripts/InputHandler/Gamepad1_right_stick.gd",
	"res://scripts/InputHandler/Gamepad2_left_stick.gd",
	"res://scripts/InputHandler/Gamepad2_right_stick.gd",
	"res://scripts/InputHandler/CPU_weak.gd",
	"res://scripts/InputHandler/CPU_medium.gd",
	"res://scripts/InputHandler/CPU_strong.gd",
	"res://scripts/InputHandler/CPU_perfect.gd"
]

var player1_input = InputHandler.MOUSE
var player2_input = InputHandler.CPU_WEAK

func _ready():
	if (OS.get_name() == "HTML5"): # default input for HTML5 is arrow keys, since the mouse does not get captured.
		player1_input = InputHandler.KEYBOARD_ARROWS
