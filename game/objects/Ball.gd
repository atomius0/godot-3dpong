extends KinematicBody

const BALL_REST_TIME = 1.0 # time in seconds until the ball starts moving
const OUT_DISTANCE = 40.0 # distance from origin on the Z axis above which the ball is considered out of the playing field.

signal ball_out

var velocity = Vector3(0.0, 0.0, 0.3)

var rest_timer = 0

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	if (rest_timer < BALL_REST_TIME):
		rest_timer += delta
		return
	
	var remaining = move(velocity * delta * 60)
	
	if is_colliding():
		var collider = get_collider()
		print("Collider: " + collider.get_name())
		print("collision_normal: " + str(get_collision_normal()))
		
		if collider.is_in_group("Paddles"):
			var angle = get_translation() - collider.get_node("AngleInfluence").get_global_transform().origin
			#print("trans: %s" % [collider.get_node("AngleInfluence").get_global_transform().origin])
			velocity = angle.normalized().reflect(velocity)
			#print("ball trans: " + str(get_translation()))
			print("paddle_normal: " + str(angle.normalized()))
		else:
			#velocity = velocity.reflect(get_collision_normal()) # vector length changes after collisions...
			velocity = get_collision_normal().reflect(velocity) # this way around it works fine.
	
	check_out_distance()


func check_out_distance():
	var z_pos = get_translation().z
	if (z_pos > OUT_DISTANCE):
		# signal parameters: self (the ball object that went out), int (out at player1's side: 1, player2's side: -1)
		emit_signal("ball_out", self, 1)
		queue_free()
	elif (z_pos < -OUT_DISTANCE):
		emit_signal("ball_out", self, -1)
		queue_free()
