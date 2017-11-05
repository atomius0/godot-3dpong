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
		velocity = velocity.reflect(get_collision_normal())
		print(velocity)
