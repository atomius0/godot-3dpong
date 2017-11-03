extends KinematicBody

var velocity = Vector3(0.1, 0.4, 0.3)

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var remaining = move(velocity)
	
	if is_colliding():
		print("collision_normal: " + str(get_collision_normal()))
		#velocity = velocity.cross(get_collision_normal())
		velocity = velocity.reflect(get_collision_normal())
