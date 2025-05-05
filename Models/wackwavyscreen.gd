extends Node3D

func _ready():
	$AnimationPlayer.get_animation("Wavey").loop = true
	$AnimationPlayer.play("Wavey")
