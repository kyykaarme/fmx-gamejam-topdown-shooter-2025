extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0

func _process(delta):
	if target:
		var current_position = global_transform.origin
		var target_position = target.global_transform.origin

		# Only follow target on X and Z; keep camera's original Y (height)
		var desired_position = Vector3(
			target_position.x,
			target_position.y + 10,
			target_position.z + 7
		)

		# Smooth follow using linear interpolation
		global_transform.origin = current_position.lerp(desired_position, delta * follow_speed)
