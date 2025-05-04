extends Node

class_name Stats
@export var max_HP = 1
@export var level = 1

#LEVELLING SYS
var currExp = 0
var expToUpgrade = 1
signal you_died_signal
signal upgrade

var current_HP = 0

func _ready():
	current_HP = max_HP
	pass
	
func take_hit(damage):
	current_HP -= damage
	print("I'm hitt", current_HP, "/", max_HP)
	if(current_HP<=0):
		die()

func get_required_exp(level):
	if(level == 1):
		return 1
	else:
		return round(pow(level,1.8) + level * 4)


func gain_exp(amount):
	currExp += amount
	if(currExp >= expToUpgrade):
		get_upgrade()
		
func die():
	emit_signal("you_died_signal")
	
func get_upgrade():
	emit_signal("upgrade")
