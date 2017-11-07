extends Camera

export(NodePath) var object_to_follow

onready var default_transform = get_transform()
var follow_object

func _ready():
	follow_object = get_node(object_to_follow)
	set_fixed_process(true)


func _fixed_process(delta):
	set_transform(follow_object.get_transform() * default_transform)
	#set_transform(default_transform * follow_object.get_transform()) # both work... are they both correct, or is there a difference?
