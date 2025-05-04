extends Node

class_name Stats
@export var max_HP = 1
@export var level = 1

#LEVELLING SYS
var currExp = 0
var expToUpgrade = 3
signal you_died_signal
signal upgrade
signal takenDam
var current_HP = 0

func _ready():
	current_HP = max_HP
	pass
	
func take_hit(damage):
	emit_signal("takenDam")
	current_HP -= damage
	#print("I'm hitt", current_HP, "/", max_HP)
	if(current_HP<=0):
		die()

func get_required_exp(level):
	if(level == 1):
		return 1
	else:
		return round(pow(level,1.2))


func gain_exp(amount):
	currExp += amount
	if(currExp >= expToUpgrade):
		get_upgrade()
		
func die():
	emit_signal("you_died_signal")
	
func get_upgrade():
	level += 1
	currExp = 0
	expToUpgrade = get_required_exp(level + 1)
	emit_signal("upgrade")
