extends Node3D

@export var Enemy: PackedScene
@onready var timer = $InBetweenWaves

@export var wave_sizes = [3, 5, 7] # Number of enemies per wave
@export var seconds_between_spawns = 2.0

var current_wave = 0
var enemies_left_in_wave = 0
var total_enemies_this_wave = 0
var spawned_enemies = 0
var dead_enemies = 0

func _ready():
	timer.wait_time = seconds_between_spawns
	_start_wave()

func _start_wave():
	if current_wave >= wave_sizes.size():
		print("All waves completed!")
		return

	enemies_left_in_wave = wave_sizes[current_wave]
	total_enemies_this_wave = enemies_left_in_wave
	print("Starting wave %d with %d enemies" % [current_wave + 1, total_enemies_this_wave])
	timer.start()

func _on_in_between_waves_timeout():
	if enemies_left_in_wave > 0:
		var enemy = Enemy.instantiate()
		get_parent().add_child(enemy)
		enemy.global_transform.origin = global_transform.origin

		var stats = enemy.get_node("Stats")
		stats.connect("you_died_signal", Callable(self, "_on_enemy_died"))

		spawned_enemies += 1
		enemies_left_in_wave -= 1

		if enemies_left_in_wave > 0:
			timer.start()
	else:
		# All enemies for this wave spawned; wait for them to die
		pass

func _on_enemy_died():
	dead_enemies += 1
	print("Enemy died! Dead count this wave: %d" % dead_enemies)

	if dead_enemies >= total_enemies_this_wave:
		current_wave += 1
		dead_enemies = 0
		spawned_enemies = 0
		_start_wave()
