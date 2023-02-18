extends Node3D

var dirtBlock = preload("res://Assets/Cubes/Dirt.tscn")
@export var dimensions: Vector2
@export var centered = false

# Called when the node enters the scene tree for the first time.
func fillGrid(dimensions, centered):
	for x in dimensions.x:
		for z in dimensions.y:
			var instance = dirtBlock.instantiate()
			var offset = Vector3(0, 0, 0)
			if centered:
				offset = Vector3(ceil(-dimensions.x/2), 0, ceil(-dimensions.y/2))
			var translation = Vector3(x, -1, z) + offset
			instance.translate(translation)
			add_child(instance)

func _ready():
#	Floor Generation
	fillGrid(dimensions, centered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
