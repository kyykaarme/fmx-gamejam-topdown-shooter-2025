extends Node3D
@onready var target = $Player
@onready var transition = $transition_screen
@onready var Cam = $Camera3d as Camera3D
@onready var SpawnerHolder = $SpawnHolder
var ray_origin = Vector3()
var ray_target = Vector3()
@onready var playerStat = target.get_node("Stats") as Stats

func _ready():
	for spawner in SpawnerHolder.get_children():
		if spawner.has_signal("new_dead"):
			spawner.new_dead.connect(_on_spawner_new_dead)

func _process(delta):
	if(target):
		get_tree().call_group("enemies", "target_position", target.global_transform.origin)

func _physics_process(delta):
	if(target):
			# Add ray follow  https://www.youtube.com/watch?v=HX6qpYjwN3M
		var mouse_position = get_viewport().get_mouse_position()
		#print(mouse_position)
		ray_origin = Cam.project_ray_origin(mouse_position)
		ray_target = ray_origin + Cam.project_ray_normal(mouse_position) * 2000
		var space_state = get_world_3d().direct_space_state
		var params = PhysicsRayQueryParameters3D.new()
		params.from = ray_origin
		params.to = ray_target
		var intersection = space_state.intersect_ray(params)
		if not intersection.is_empty():
			#print("NOT EMPTY")
			var pos = intersection.position
			var look_at_me = Vector3(pos.x, $Player/Body.global_position.y, pos.z)
			$Player/Body.look_at(look_at_me, Vector3.UP) 


func _on_player_die_from_falling() -> void:
	transition.play("fade_out")
	#print("dieeee")


func _on_player_die_from_killed() -> void:
	transition.play("fade_out")
	#print("dieeee")


func _on_spawner_new_dead():
	playerStat.gain_exp(1)
	#print(playerStat.currExp, "/", playerStat.expToUpgrade, "update to level", playerStat.level)


func _on_cage_holder_win_level() -> void:
	transition.play("fade_out")
	get_tree().change_scene_to_file("res://Scenes/Menu/next_level.tscn")
