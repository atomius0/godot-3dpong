extends Control

const ALPHA = 0.5
onready var label = get_node("Label")

func _ready():
	set_hidden(true)
	set_process_input(false)
	get_node("../Pong").connect("player_wins", self, "_on_player_wins")


func _draw():
	draw_rect(get_viewport_rect(), Color(0.0, 0.0, 0.0, ALPHA))


func _input(event):
	if (event.is_action("menu_accept") and event.is_pressed() and not event.is_echo()):
		get_tree().change_scene("res://scenes/TitleScreen.tscn")


func _on_player_wins(player):
	if (player == 1):
		label.set_text("Player 1 wins!")
	elif (player == -1):
		label.set_text("Player 2 wins!")
	
	set_hidden(false)
	set_process_input(true)
