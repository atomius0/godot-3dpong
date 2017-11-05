extends Node

onready var paddle = get_node("..")
onready var ball = paddle.get_node("../Ball")

func _ready():
	pass


func _get_movement():
	var pos = paddle.get_translation()
	var target = ball.get_translation()
	return Vector2(target.x - pos.x, target.y - pos.y)
