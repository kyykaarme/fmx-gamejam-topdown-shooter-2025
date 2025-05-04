extends Node3D
@onready var target = $Player

@onready var Cam = $Camera3d as Camera3D
var ray_origin = Vector3()
var ray_target = Vector3()

func _process(delta):
	get_tree().call_group("enemies",aaaa "target_position", target.global_transform.origin)

func _physics_process(delta):
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
		print("NOT EMPTY")
		var pos = intersection.position
		var look_at_me = Vector3(pos.x, $Player.global_position.y, pos.z)
		$Player.look_at(look_at_me, Vector3.UP) 
