extends RigidBody3D

var speed = 20.0
var damage = 10

func _ready():
	gravity_scale = 0 
	linear_velocity = -global_transform.basis.z * speed
	

func _on_hit_area_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
