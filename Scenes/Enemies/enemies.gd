extends CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var raycast: RayCast3D = $RayCast3D
@onready var timer: Timer = $Timer
var speed: float = 5.0
var direction: Vector3 = Vector3.ZERO
var player: CharacterBody3D
var health: int = 50


func _ready():
	# Get player node (adjust path if your scene structure differs)
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]
	# Set initial target location to player
	if player:
		navigation_agent.set_target_position(player.global_position)
	# Connect timer for periodic path updates
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta):
	if player:
		# Get current and next positions for navigation
		var current_position = global_position
		var next_position = navigation_agent.get_next_path_position()
		direction = (next_position - current_position).normalized()
		velocity = direction * speed
		# Smooth movement to avoid jitter
		velocity = velocity.move_toward(velocity, 0.25)
		move_and_slide()
		
		# Attack logic with raycast
		if raycast.is_colliding() and raycast.get_collider() == player:
			player.take_damage(10)  # Ensure Player has take_damage method

func _on_timer_timeout():
	if player and global_position.distance_to(player.global_position) < 100:
		# Update navigation target to player's current position
		navigation_agent.set_target_position(player.global_position)

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		var spawner = get_tree().current_scene.get_node("EnemySpawner")
		spawner.enemy_count -= 1
		queue_free()
