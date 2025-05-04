extends CharacterBody3D

var _bullet_scene= load("res://Scenes/Bullet/Bullet.tscn")
var health = 100
var mouseSensibility = 1200
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var gunControllor = $GunController
#func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle Shooting
	if Input.is_action_just_pressed("Shoot"):
		gunControllor.shoot()
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	#if Input.is_action_just_pressed("Escape"): 
		#capMouse = !capMouse
		#if capMouse:
			#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#else: 
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
