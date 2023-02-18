extends Node3D

@export var spawnedEntity = load("res://GameObjects/Characters/Golems/mudGolem.tscn")
@export var target: RigidBody3D
@export var wait_time: float = 5

var this = $"."
var rng = RandomNumberGenerator.new()

@onready var timer = Timer.new()
@onready var map = this.get_parent().get_parent()

func spawn(entity, count: int = 1):
	for i in count:
		var instance = entity.instantiate()
		instance.transform.origin = this.global_position
		instance.rotation.y = this.rotation.y
		instance.translate(Vector3(0, 2, 0))
		instance.target = target
		map.add_child(instance)

func _on_timer_timeout():
	spawn(spawnedEntity)

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = true
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = wait_time
	timer.start(wait_time)
	add_child(timer)
	spawn(spawnedEntity, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
