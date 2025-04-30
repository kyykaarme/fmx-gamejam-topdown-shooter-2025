extends RigidBody3D

var speed = 10.0
var damage = 10

func _ready():
	# Apply impulse in the forward direction (-Z in Godot's 3D)
	apply_impulse(transform.basis.z * -speed)

func _on_hit_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
	queue_free()
