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

var player1_input = InputHandler.MOUSE
var player2_input = InputHandler.CPU_PERFECT # TODO: change to CPU_WEAK once implemented.
