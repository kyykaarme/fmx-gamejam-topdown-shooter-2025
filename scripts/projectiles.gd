extends RigidBody3D

var speed = 20.0
var damage = 10

func _ready():
	apply_impulse(transform.basis.z * -speed)

func _on_hit_area_body_entered(body):
	print("Projectile hit: ", body.name, " in group enemy: ", body.is_in_group("enemy"))
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()
