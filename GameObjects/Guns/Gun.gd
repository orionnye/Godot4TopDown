extends Node3D

@export var bulletRef = load("res://GameObjects/Guns/Bullets/Bullet.tscn")

@onready var map = get_parent().get_parent()

@export var firePower = 20
@export var bulletCount = 1
@export var fireDelay: float = 0.2
@export var spread: float = 0.1

var coolingDown = false
var timer = Timer.new()

func _on_timer_timeout():
	coolingDown = false

func fire():
	if (!coolingDown):
		var rng = RandomNumberGenerator.new()
		for i in bulletCount:
#			random rotation
			rng.randomize()
			var randX = (rng.randf()*spread) - spread/2
			rng.randomize()
			var randY = (rng.randf()*spread) - spread/2
			rng.randomize()
			var randZ = (rng.randf()*spread) - spread/2
			
#			random translation
			var startRange = 0.001
			rng.randomize()
			var randPosX = rng.randf()*startRange - startRange/2
			rng.randomize()
			var randPosY = rng.randf()*startRange - startRange/2
			rng.randomize()
			var randPosZ = rng.randf()*startRange - startRange/2
			
			var offset = Vector3(randX, randY, randZ)
			var rotationOffset = global_rotation + offset
			var bulletOffset = Vector3(randPosX, randPosY, randPosZ)
			var bullet = bulletRef.instantiate()
			bullet.transform.origin = global_position + bulletOffset
			
			var velocity = Vector3(0, 0, firePower).rotated(Vector3(0, 1, 0), rotationOffset.y)
			velocity = velocity.rotated(Vector3(1, 0, 0), rotationOffset.x)
			velocity = velocity.rotated(Vector3(0, 0, 1), rotationOffset.z)

			bullet.apply_central_impulse(velocity)
			map.add_child(bullet)
	#	CoolDown Timer
		timer.autostart = false
		timer.connect("timeout", _on_timer_timeout)
		add_child(timer)
		timer.start(fireDelay)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
