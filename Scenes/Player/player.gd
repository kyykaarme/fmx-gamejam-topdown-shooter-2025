extends CharacterBody3D

@export var _bullet_scene: PackedScene
@export var health = 100
@export var mouseSensibility = 1200
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

# Jump & Dash
var can_double_jump = true
var is_dashing = false
var dash_speed = 20.0
var dash_duration = 0.2
var dash_timer = 0.0
var dash_direction = Vector3.ZERO

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var gunControllor = $GunController

func _ready():
	global_transform.origin = Vector3(0, 0, 0)


func _physics_process(delta):
	# Fall check
	if global_transform.origin.y < -10:  # Adjust based on your map
		_fell_off_map()
	
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		can_double_jump = true  # Reset when touching ground

	# Jump
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			velocity.y = JUMP_VELOCITY
			can_double_jump = false

	# Dash input
	if Input.is_action_just_pressed("Dash") and not is_dashing:
		var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction != Vector3.ZERO:
			is_dashing = true
			dash_timer = dash_duration
			dash_direction = direction

	# Dashing logic
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		# Normal movement
		var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func _on_stats_you_died_signal() -> void:
	queue_free()
	print("GAME OVER")
	
func _fell_off_map():
	queue_free()
	print("You fell off the map.")
