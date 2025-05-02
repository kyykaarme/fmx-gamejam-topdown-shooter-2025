extends CharacterBody3D

var speed = 5.0
var health = 100
@onready var muzzle = $Muzzle
@onready var shoot_timer = $ShootTimer
@onready var projectile_scene = preload("res://scenes/projectile.tscn")

func _ready():
	# Make sure the shoot timer is started when the player is ready
	if shoot_timer.is_stopped():
		shoot_timer.start()

func _physics_process(delta):
	# Movement with WASD keys
	var input_dir = Vector2(
		Input.get_axis("ui_left", "ui_right"),  # A and D
		Input.get_axis("ui_up", "ui_down")      # W and S
	).normalized()
	var direction = Vector3(input_dir.x, 0, input_dir.y)
	velocity = direction * speed
	move_and_slide()
	
	# Rotation - only rotate if mouse position is valid
	var mouse_pos = get_mouse_position_3d()
	if mouse_pos:
		look_at(Vector3(mouse_pos.x, position.y, mouse_pos.z), Vector3.UP)

func shoot():
	var projectile = projectile_scene.instantiate()
	get_tree().root.add_child(projectile)
	projectile.global_transform = muzzle.global_transform
	# Explicitly set the projectile's direction to match the muzzle's forward direction
	projectile.look_at(muzzle.global_position - muzzle.global_transform.basis.z, Vector3.UP)

func get_mouse_position_3d():
	var camera = get_viewport().get_camera_3d()
	var mouse_pos = get_viewport().get_mouse_position()
	
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_normal = camera.project_ray_normal(mouse_pos)
	var plane = Plane(Vector3.UP, 0)
	# Corrected to use direction vector
	var intersection = plane.intersects_ray(ray_origin, ray_normal)
	return intersection

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()

func _on_shoot_timer_timeout():
	# Auto-shoot when timer times out
	shoot()
