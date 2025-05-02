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
	var enemy = enemy_scene.instantiate()
	$Enemies.add_child(enemy)  # Add to scene tree first
	enemy.position = Vector3(
		randf_range(-20, 20),
		0,
		randf_range(-20, 20)
	)
