extends CharacterBody3D

var speed = 5.0
var health = 100
@onready var muzzle = $Muzzle
@onready var shoot_timer = $ShootTimer
@onready var projectile_scene = preload("res://scenes/projectile.tscn")

func _physics_process(delta):
	var input_dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	var direction = Vector3(input_dir.x, 0, input_dir.y)
	velocity = direction * speed
	move_and_slide()
	var mouse_pos = get_mouse_position_3d()
	if mouse_pos:
		look_at(Vector3(mouse_pos.x, position.y, mouse_pos.z), Vector3.UP)

func get_mouse_position_3d():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_normal = camera.project_ray_normal(mouse_pos)
	var plane = Plane(Vector3.UP, 0)
	var intersection = plane.intersects_ray(ray_origin, ray_origin + ray_normal * 1000)
	return intersection

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()

func _on_shoot_timer_timeout():
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.call_deferred("set", "global_position", muzzle.global_position)
	projectile.call_deferred("set", "global_rotation", global_rotation)
