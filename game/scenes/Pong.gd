# Pong.gd
# the game manager for 3D Pong.
# keeps track of scores, ball(s), etc.
# also (re)spawns the ball(s).

extends Spatial

const RANDOM_SEED = 1

signal score_updated

var ball_scene = preload("res://objects/Ball.tscn")

var balls = []

var score_p1 = 0
var score_p2 = 0

func spawn_ball(side, random_angle):
	var ball = ball_scene.instance()
	add_child(ball)
	balls.append(ball)
	ball.connect("ball_out", self, "_ball_out")
	
	ball.init_velocity(side, random_angle)
	#return ball # returning ball is not required.
	

func _ready():
	seed(RANDOM_SEED) # initialize random number generator with a constant seed.
	#set_fixed_process(true)
	spawn_ball(-1, false)
	# test:
	#spawn_ball().velocity = Vector3(0.1, 0.2, 0.3) # multiple balls work!


#func _fixed_process(delta):
#	pass

func _ball_out(ball, direction):
	if (direction < 0):
		score_p1 += 1
	elif (direction > 0):
		score_p2 += 1
	
	balls.erase(ball) # remove ball from array
	emit_signal("score_updated", score_p1, score_p2)
	
	print("ball out: %s, %s" % [ball, direction])
	print("Score: %d : %d" % [score_p1, score_p2])
	
	spawn_ball(direction, true)
