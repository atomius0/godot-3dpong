extends KinematicBody

var velocity = Vector3(0.0, 0.0, 0.3)

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
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
		
		#print(velocity)
