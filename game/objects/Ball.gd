extends KinematicBody

const BALL_REST_TIME = 1.0 # time in seconds until the ball starts moving
const START_SPEED = 0.2 # starting speed of the ball. should be a positive floating point value.
const MAX_START_ANGLE = 1.0 # maximum stating angle of the ball. 0.0 = straight, 1.0 = ~45 degrees.
const MAX_SPEED = 1.0

const OUT_DISTANCE = 40.0 # distance from origin on the Z axis above which the ball is considered out of the playing field.

signal ball_out

var velocity = Vector3(0.0, 0.0, START_SPEED) # if init_velocity() is not called, make the ball fly straight towards Paddle 1.

var rest_timer = 0
var prev_paddle_col_side = 0 # for preventing the ball from reaching MAX_SPEED instantly when it gets stuck on a paddle's edge.

func _ready():
	#init_velocity()
	set_fixed_process(true)


func _fixed_process(delta):
	if (rest_timer < BALL_REST_TIME):
		rest_timer += delta
		return
	
	var remaining = move(velocity * delta * 60)
	
	if is_colliding():
		var collider = get_collider()
		#print("Collider: " + collider.get_name())
		#print("collision_normal: " + str(get_collision_normal()))
		
		if collider.is_in_group("Paddles"):
			var angle = get_translation() - collider.get_node("AngleInfluence").get_global_transform().origin
			#print("trans: %s" % [collider.get_node("AngleInfluence").get_global_transform().origin])
			velocity = angle.normalized().reflect(velocity)
			#print("ball trans: " + str(get_translation()))
			#print("paddle_normal: " + str(angle.normalized()))
			
			var paddle_col_side
			if (get_translation().z > 0):
				paddle_col_side = 1
			else:
				paddle_col_side = -1
			
			if (prev_paddle_col_side != paddle_col_side):
				prev_paddle_col_side = paddle_col_side
				increase_speed()
		else:
			#velocity = velocity.reflect(get_collision_normal()) # vector length changes after collisions...
			velocity = get_collision_normal().reflect(velocity) # this way around it works fine.
	
	check_out_distance()


func init_velocity(side, random_angle):
	# initializes the ball's velocity
	# should be called by the creator of the ball.
	# parameters:
	#  side = int. -1 = toward player 2, +1 = toward player 1.
	#  random_angle = bool. true = angle will be random, false = ball will fly straight towards the player.
	
	var dir = Vector3()
	
	if (side < 0):
		dir.z = -1
	else:
		dir.z = 1
	
	if (random_angle):
		dir.x = rand_range(-MAX_START_ANGLE, MAX_START_ANGLE)
		dir.y = rand_range(-MAX_START_ANGLE, MAX_START_ANGLE)
	
	velocity = dir.normalized() * START_SPEED
	#print("init_velocity: %s" % [velocity])


func check_out_distance():
	var z_pos = get_translation().z
	if (z_pos > OUT_DISTANCE):
		# signal parameters: self (the ball object that went out), int (out at player1's side: 1, player2's side: -1)
		emit_signal("ball_out", self, 1)
		queue_free()
	elif (z_pos < -OUT_DISTANCE):
		emit_signal("ball_out", self, -1)
		queue_free()


func increase_speed():
#	# prevent speed from increasing if there was no change in z direction since last call to increase_speed()
#	# velocity.z is negated, since the ball has already been reflected by the paddle when this method is called.
#	if ( (-velocity.z < 0 and prev_z_dir < 0) or (-velocity.z > 0 and prev_z_dir > 0) ):
#		# moving in the same direction as before, this means that the ball somehow got stuck at the paddle's edge.
#		# to prevent it from reaching max speed instantly, we simply return, without increasing the speed.
#		print("same direction!!!! velocity.z: %s, prev_z_dir: %s" % [velocity, prev_z_dir])
#		return
#	else:
#		# moving in the opposite direction now, everything is fine.
#		print("other direction :) velocity.z: %s, prev_z_dir: %s" % [velocity, prev_z_dir])
#		if (velocity.z < 0):
#			prev_z_dir = 1
#		else:
#			prev_z_dir = -1
	velocity = velocity.normalized() * (min(velocity.length() + 0.025, MAX_SPEED))
	#if (velocity.z > 0):
	#	velocity += Vector3(0.0, 0.0, 0.1)
	#else:
	#	velocity += Vector3(0.0, 0.0, -0.1)
	print("Velocity: %s" % [velocity.length()])
