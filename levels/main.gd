extends Node3D
@onready var target = $Player

@onready var Cam = $Camera3d as Camera3D
var ray_origin = Vector3()
var ray_target = Vector3()

func _process(delta):
	get_tree().call_group("enemies", "target_position", target.global_transform.origin)

#essetially just a counter
@onready var current_level=0
#the level is the key the amount of monsters is the value
@onready var monster_dict={
 1:1,
 2:2,
 3:4,
 4:8,
 5:30
}

#the monster we will be spawning in. 
@onready var monster=preload("res://Scenes/Enemies/enemies.tscn")
#A random number genrerator to spawn from alternating spawn points.
@onready var rand=RandomNumberGenerator.new()
@onready var dead_enemies=0

func _ready():
	add_to_group("level")

func enemy_death():
	print("enemy death")
	dead_enemies+=1
	if dead_enemies==monster_dict[current_level]:
		$InBetweenWaves.start()
		dead_enemies=0
 #get_tree().call_group("player", "award_points", 200)

func spawn_enemies():
	for i in range(monster_dict[current_level]):
		var m = monster.instantiate()
		print("spawning enemy")
	  #we check the amount of children on our spawn holder 
		var spawn_length = $SpawnHolder.get_child_count()-1
	  #then make a random number in that range
		var rand_num = rand.randi_range(0,spawn_length)
	  #We use that number to randomly select a spawner node position to use 
		var spawn_postion = $SpawnHolder.get_child(rand_num).position
	  #we add the monster as a child of the level
	  #We set the monsters position to the spawn location
		m.position = spawn_postion
		add_child(m)

func update_level(level):
	match level:
		1:
			print("its level one")
	   #additional stuff here like announcer saying: Wave 1!
		2:
			print("its level two")
		3:
			print("its level three")
		4:
			print("its level four")
		5:
			print("its level five")
	spawn_enemies()



func _on_in_between_waves_timeout():
	print("Leaving level: ", current_level)
	current_level+=1
	update_level(current_level)



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
