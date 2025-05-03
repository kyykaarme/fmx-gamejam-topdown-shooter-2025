extends Node3D

@export var Bullet: PackedScene
@export var muzzle_speed = 30
@export var delay = 100
@onready var pos=$Gun/Pos

	
func _process(delta):
	shoot()
	
func shoot():
	var instance = Bullet.instantiate()
	instance.position = pos.global_position
	instance.speed = muzzle_speed
	instance.transform.basis=pos.global_transform.basis
	get_parent().add_child(instance)
