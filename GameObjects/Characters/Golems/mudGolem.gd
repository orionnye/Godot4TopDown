extends RigidBody3D

@export @onready var target: RigidBody3D
@export var accelRate: float
@export var hp: int = 1

func follow(target, delta):
	var difference = target.position - position
	var push = Vector3(difference.x, 0, difference.z).normalized()*accelRate
	apply_central_force(push)

func set_hp(amount: int):
	if (amount < hp):
		hp = amount
	else:
		hp = amount

func check_collisions():
	var collisions = get_colliding_bodies()
	for i in collisions:
		if (i.name == "Bullet"):
			set_hp(0)
			print("Post bulletCollision:", hp)

# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_collisions()
	if target != null:
		follow(target, delta)
	if (hp <= 0):
		get_parent().remove_child(self)
	
#	Kill plane
	if (position.y < -1):
		get_parent().remove_child(self)
