extends Node


@export var StartingWeapon: PackedScene
var Hand 
var equipped_weapon: Node3D


func _ready():
	Hand = get_parent().find_child("Hand")
	if StartingWeapon:
		equip_weapon(StartingWeapon)


func equip_weapon(weapon_to_equip):
	if equipped_weapon:
		print("Deleting ...")
		equipped_weapon.queue_free()
	else:
		print("No weapon")
		equipped_weapon = weapon_to_equip.instantiate()
		Hand.add_child(equipped_weapon)
		
		
func shoot():
	if equipped_weapon:
		print("pewww")
		equipped_weapon.shoot()
