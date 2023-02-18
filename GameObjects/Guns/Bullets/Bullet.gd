extends RigidBody3D

@export var liveTime: float
var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start(liveTime)
	add_child(timer)
	contact_monitor = true
	max_contacts_reported = 4
	
func _on_timer_timeout():
	get_parent().remove_child(self)

func _process(delta):
	pass
