extends CharacterBody3D
@onready var nav = $NavigationAgent3D
@export var enemy_speed = 2
var gravity = 9.8
func _process(delta):
	if not is_on_floor():
		velocity.y -= gravity*delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var current_location = global_transform.origin
	var new_velocity = (next_location - current_location).normalized() * enemy_speed
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()
	
func target_position(target):
	nav.target_position = target


func _on_stats_you_died_signal() -> void:
	queue_free()
