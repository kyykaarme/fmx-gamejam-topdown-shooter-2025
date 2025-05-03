extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_points: Array[Node3D]
@export var max_enemies: int = 10
var enemy_count: int = 0

func _ready():
	$SpawnTimer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout():
	if enemy_count < max_enemies and spawn_points.size() > 0:
		var spawn_point = spawn_points[randi() % spawn_points.size()]
		
		if not spawn_point.is_inside_tree():
			print("Spawn point not ready yet.")
			return
		
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_point.global_position
		get_tree().current_scene.add_child(enemy)
		enemy_count += 1
		print("Spawned enemy, total:", enemy_count)
