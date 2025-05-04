extends Node

class_name Stats
@export var max_HP = 1
signal you_died_signal

var current_HP = max_HP

func _ready():
	pass
	
func take_hit(damage):
	current_HP -= damage
	#print("I'm hitt", current_HP, "/", max_HP)
	if(current_HP<=0):
		die()
		
func die():
	emit_signal("you_died_signal")
