extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player:
		position = Vector3(player.position.x, position.y, player.position.z)
