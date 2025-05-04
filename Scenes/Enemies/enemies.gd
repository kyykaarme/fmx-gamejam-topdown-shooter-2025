extends CharacterBody3D
@onready var nav = $NavigationAgent3D
@export var enemy_speed = 0.25
@export var attacking_speed = 5

@onready var timer = $AttackTimer
var gravity = 9.8

enum state {
	SEEKING,
	ATTACKING,
	RESTING,
}

var current_state = state.SEEKING

func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity*delta
	else:
		velocity.y -= 2
	match current_state:
		state.SEEKING:
			var next_location = nav.get_next_path_position()
			var current_location = global_transform.origin
			var new_velocity = (next_location - current_location).normalized() * enemy_speed
			velocity = velocity.move_toward(new_velocity, 0.25)
			move_and_slide()
		state.ATTACKING:
			move_and_attack()
		state.RESTING:
			if not timer.is_stopped():
				move_and_slide()
			else:
				timer.start(1.5)  # 1.5 seconds of resting
				timer.connect("timeout", Callable(self, "_on_resting_done"))
	
func target_position(target):
	nav.target_position = target

func move_and_attack():
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * attacking_speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
		# Check distance to the player
	var distance_to_player = current_location.distance_to(next_location)

	# If you want to stop moving if you're too close
	if distance_to_player < 1.0: 
		current_state = state.RESTING
	
	
func _on_stats_you_died_signal() -> void:
	queue_free()


func _on_area_3d_body_entered(body):
	if (body.is_in_group("player")):
		timer.start()
		current_state = state.ATTACKING


func _on_attack_timer_timeout():
	current_state = state.SEEKING

func _on_resting_done():
	current_state = state.ATTACKING
