extends Node

onready var paddle = get_node("..")
onready var balls = get_node("../..").balls

func _ready():
	pass


func _get_movement():
	if (balls.size() < 1): # if there is no ball, we don't want to move. return zero-vector.
		return Vector2()
	
	# TODO: get closest ball
	var closest_ball = balls[0]
	
	var pos = paddle.get_translation()
	var target = closest_ball.get_translation()
	return Vector2(target.x - pos.x, target.y - pos.y)
