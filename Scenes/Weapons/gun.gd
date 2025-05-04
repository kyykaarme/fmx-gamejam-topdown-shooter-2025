extends Node3D

@export var Bullet: PackedScene
@export var muzzle_speed = 30
@export var delay = 0.1
@onready var pos= $Gun/Pos
@onready var timer = $Timer
var canShoot = true

func _ready():
	timer.wait_time = delay

#func _process(delta):
	#shoot()
	
func shoot():
	print("gay")
	if canShoot: 
		var instance = Bullet.instantiate()
		instance.speed = muzzle_speed
		instance.global_transform=pos.global_transform
		var scene_root = get_tree().current_scene
		scene_root.add_child(instance)
		canShoot = false
		timer.start()
	if delay > 0:
		delay -= 0.1



func _on_timer_timeout():
	canShoot = true
