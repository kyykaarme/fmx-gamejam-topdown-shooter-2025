extends Node3D

@onready var FX = $Hearts
@onready var anim_player = $AnimationPlayer
@onready var cage = $CageCylinder007

var death_anim : Animation = preload("res://Models/anim/Open.res")

func _on_stats_you_died_signal():
	FX.emitting = true  # start particle effect
	$AnimationPlayer.play("Open")
