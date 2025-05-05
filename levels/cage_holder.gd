extends Node3D

class_name CageHolder

signal winLevel

func _check_children():
	if get_child_count() <= 0:
		emit_signal("winLevel")

func _process(delta):
	_check_children()
