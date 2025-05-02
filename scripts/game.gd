extends Node3D

@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var spawn_timer = $SpawnTimer
@onready var health_label = $UI/Label
@onready var player = $Player  # Move to @onready to ensure proper initialization

func _ready():
	spawn_timer.wait_time = 2.0
	spawn_timer.start()

func _process(delta):
	if player:
		health_label.text = "Health: " + str(player.health)
	else:
		health_label.text = "Health: N/A"  # Fallback if player is not found

func _on_spawn_timer_timeout():
	if not player:
		return
		
	var player_forward = -player.global_transform.basis.z
	
	var spawn_distance = randf_range(5.0, 10.0)
	var angle_range = PI/4
	
	var random_angle = randf_range(-angle_range, angle_range)
	
	var base_direction = player_forward
	
	var spawn_direction = base_direction.rotated(Vector3.UP, random_angle)
	
	var spawn_position = player.global_position + spawn_direction * spawn_distance
	
	spawn_position.y = 0
	
	var enemy = enemy_scene.instantiate()
	$Enemies.add_child(enemy)
	enemy.global_position = spawn_position
