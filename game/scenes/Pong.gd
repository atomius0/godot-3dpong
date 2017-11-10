# Pong.gd
# the game manager for 3D Pong.
# keeps track of scores, ball(s), etc.
# also (re)spawns the ball(s).

extends Spatial

const RANDOM_SEED = 1

signal score_updated
signal player_wins

var ball_scene = preload("res://objects/Ball.tscn")

var balls = []

var score_p1 = 0
var score_p2 = 0

func _ready():
	init_input_handlers()
	seed(RANDOM_SEED) # initialize random number generator with a constant seed.
	#set_fixed_process(true)
	spawn_ball(-1, false)
	# test:
	#spawn_ball().velocity = Vector3(0.1, 0.2, 0.3) # multiple balls work!


func init_input_handlers():
	change_input_handler(get_node("Paddle1"), Global.player1_input)
	change_input_handler(get_node("Paddle2"), Global.player2_input)


func change_input_handler(paddle_node, input_handler_id):
	# lookup script name, load and instance the InputHandler script:
	var new_input_handler = load(Global.INPUT_HANDLER_SCRIPTS[input_handler_id]).new()
	
	new_input_handler.set_name("InputHandler")
	#new_input_handler.set_owner(paddle_node) # we don't need to set the owner
	
	# replace the old InputHandler node by the new one:
	paddle_node.get_node("InputHandler").replace_by(new_input_handler)
	
	# register the new InputHandler with the paddle, otherwise it will still try to access the old one:
	paddle_node.input_handler = new_input_handler


func spawn_ball(side, random_angle):
	var ball = ball_scene.instance()
	add_child(ball)
	balls.append(ball)
	ball.connect("ball_out", self, "_ball_out")
	
	ball.init_velocity(side, random_angle)
	#return ball # returning ball is not required.


func _ball_out(ball, direction):
	if (direction < 0):
		score_p1 += 1
	elif (direction > 0):
		score_p2 += 1
	
	balls.erase(ball) # remove ball from array
	emit_signal("score_updated", score_p1, score_p2)
	
	print("ball out: %s, %s" % [ball, direction])
	print("Score: %d : %d" % [score_p1, score_p2])
	
	var won = has_player_won()
	if (won == 0):
		spawn_ball(direction, true)
	elif (won == 1):
		print("Player 1 has won!")
		emit_signal("player_wins", 1)
	elif (won == -1):
		print("Player 2 has won!")
		emit_signal("player_wins", -1)


func has_player_won():
	# returns 1 for player 1, -1 for player 2, 0 if no one has won yet.
	var max_score = max(score_p1, score_p2)
	var min_score = min(score_p1, score_p2)
	
	# a player wins if he has at least 11 points and at least 2 more points than his opponent.
	if ( max_score >= 11 and (max_score - min_score) >= 2 ):
		if (score_p1 > score_p2):
			return 1 # player 1 has won
		else:
			return -1 # player 2 has won
	
	return 0 # no one has won yet
