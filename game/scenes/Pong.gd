# Pong.gd
# the game manager for 3D Pong.
# keeps track of scores, ball(s), etc.
# also (re)spawns the ball(s).

extends Spatial

var ball_scene = preload("res://objects/Ball.tscn")

var balls = []

var score_p1 = 0
var score_p2 = 0

func spawn_ball():
	var ball = ball_scene.instance()
	add_child(ball)
	balls.append(ball)
	ball.connect("ball_out", self, "_ball_out")
	

func _ready():
	#set_fixed_process(true)
	spawn_ball()


#func _fixed_process(delta):
#	pass

func _ball_out(ball, direction):
	balls.erase(ball)
	print("ball out: %s, %s" % [ball, direction])
