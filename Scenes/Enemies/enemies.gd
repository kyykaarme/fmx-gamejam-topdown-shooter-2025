extends CharacterBody3D
@onready var nav = $NavigationAgent3D
@export var enemy_speed = 0.25
@export var attacking_speed = 5
@export var enemy_damage = 1
@onready var timer = $AttackTimer
@onready var restingTimer = $restingTimer
@onready var FX = $Explosion

var gravity = 9.8

enum state {	SEEKING,
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
			timer.start()
	
func target_position(target):
	nav.target_position = target

func move_and_attack():
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * attacking_speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
	var distance_to_player = current_location.distance_to(next_location)
	if distance_to_player < 1.0: 
		current_state = state.RESTING	
		
#Take Hit
func _on_stats_you_died_signal():
	FX.emitting = true  # start particle effect
	$AnimatedSprite3D.visible = false #Change this when you want to 3D
	await get_tree().create_timer(1.5).timeout  # wait 0.5 seconds
	queue_free()


#Detecting Player
func _on_area_3d_body_entered(body):
	if (body.is_in_group("player")):
		timer.start()
		current_state = state.ATTACKING

func _on_attack_timer_timeout():
	current_state = state.RESTING

func _on_resting_timer_timeout():
	current_state = state.SEEKING

#Hurting Player

func _on_hurt_area_body_entered(body):
	if (body.is_in_group("player")):
		var player_stats = body.get_node("Stats") as Stats
		print("I'm hitt", player_stats.current_HP, "/", player_stats.max_HP)
		player_stats.take_hit(enemy_damage)
