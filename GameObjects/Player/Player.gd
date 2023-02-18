extends RigidBody3D

var this = $"."
@export var accelRate = 20
@export var hp: int = 10
@export var damage_delay: float = 0.5
var invincible = false

@onready var map = $".."
@export @onready var weapon: Node3D

@onready var cam = $"Camera3D"
@onready var hpText = $"Camera3D/HP"
@export var golem: RigidBody3D

func start_IFrames(duration: float):
	invincible = true
#	print("invincible before: ", invincible)
	await( get_tree().create_timer(duration).timeout )
	invincible = false
#	print("invincible after: ", invincible)

func set_hp(amount: int):
#	losing hp
	if (amount < hp && !invincible):
		start_IFrames(damage_delay)
		hp = amount
#	gaining hp
	if (amount > hp):
		hp = amount
	hpText.text = "Health: " + str(hp)

func move(delta):
	var acceleration = Vector3(0, 0, 0)
	if Input.is_action_pressed("move_right"):
		acceleration += Vector3(-1, 0, 0)
	if Input.is_action_pressed("move_left"):
		acceleration += Vector3(1, 0, 0)
	if Input.is_action_pressed("move_forward"):
		acceleration += Vector3(0, 0, 1)
	if Input.is_action_pressed("move_backward"):
		acceleration += Vector3(0, 0, -1)
	this.apply_central_force((acceleration.normalized()*accelRate))

func get_mouseDirection() -> Vector2:
	var mousePos = get_viewport().get_mouse_position()
	var playerCamPos = cam.unproject_position(this.position)
	return mousePos - playerCamPos

func aim():
	var mouseDir = get_mouseDirection()
	var mouseSpot = this.position + Vector3(mouseDir.x, 0, mouseDir.y)
	this.look_at(mouseSpot, Vector3.UP)

# Called when the node enters the scene tree for the first time.
func _ready():
	var this = $"."
	this.contact_monitor = true

func _process(delta):
	var this = $"."
	var golem = load("res://GameObjects/Characters/Golems/mudGolem.tscn")
	var collisions = this.get_colliding_bodies()
	
	if (collisions.size() > 0):
		for i in collisions:
			if (i.name == "mudGolem") && hp > 0:
				set_hp(hp - 1)
	
	if Input.is_action_just_pressed("shoot"):
		weapon.fire()
	if Input.is_action_just_pressed("ui_accept"):
		set_hp(hp+1)
	move(delta)

func _integrate_forces(state):
	aim()
