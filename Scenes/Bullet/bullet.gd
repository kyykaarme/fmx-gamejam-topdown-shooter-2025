extends CharacterBody3D
@export var speed = 50

const  KILL_TIME = 2
var timer = 0

func _process(delta):
	position += transform.basis * Vector3(0,0,-speed) * delta
	timer += delta
	if timer == KILL_TIME:
		queue_free()
