extends Camera3D

@export var fixedOffset: Vector3
@export var fixedRotation: Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var parent = self.get_parent()
	global_transform.origin = parent.global_transform.origin + fixedOffset
	global_rotation_degrees = fixedRotation
