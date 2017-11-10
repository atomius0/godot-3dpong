extends Control

onready var p1_label = get_node("Player1")
onready var p2_label = get_node("Player2")

func _ready():
	get_node("../Pong").connect("score_updated", self, "_on_score_updated")
	_on_score_updated(0, 0) # init score labels


func _on_score_updated(score_p1, score_p2):
	p1_label.set_text(str(score_p1))
	p2_label.set_text(str(score_p2))
