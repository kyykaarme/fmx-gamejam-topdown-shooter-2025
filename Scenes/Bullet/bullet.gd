extends Node3D
@export var speed = 50
@export var damage = 1

const  KILL_TIME = 2
var timer = 0

func _process(delta):
	position += transform.basis * Vector3(0,0,-speed) * delta
	timer += delta
	if timer == KILL_TIME:
		queue_free()


func _on_area_3d_body_entered(body):
	queue_free()
	if body.has_node("Stats"):
		var stat_node = body.find_child("Stats") as Stats
		stat_node.take_hit(damage)
