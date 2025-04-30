extends CharacterBody3D

var speed = 5.0  # Movement speed in meters per second
@onready var muzzle = $Muzzle

func _physics_process(delta):
	# Get input direction (WASD or arrow keys)
	var input_dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()

	# Convert 2D input to 3D movement (X-Z plane)
	var direction = Vector3(input_dir.x, 0, input_dir.y)
	velocity = direction * speed
	move_and_slide()

	# Rotate to face mouse
	var mouse_pos = get_mouse_position_3d()
	if mouse_pos:
		look_at(Vector3(mouse_pos.x, position.y, mouse_pos.z), Vector3.UP)
		
func get_mouse_position_3d():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_normal = camera.project_ray_normal(mouse_pos)
	var plane = Plane(Vector3.UP, 0)  # Ground plane at Y=0
	var intersection = plane.intersects_ray(ray_origin, ray_origin + ray_normal * 1000)
	return intersection
