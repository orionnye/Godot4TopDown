extends Node

@export @onready var target: Node3D
@export var accelRate: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func follow(target, delta):
	var this: RigidBody3D = $"."
	var difference = target.position - this.position
	var push = Vector3(difference.x, 0, difference.z).normalized()*accelRate
	this.apply_central_force(push)
#	print("difference: ", difference)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		follow(target, delta)
