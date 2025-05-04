extends Node3D


@onready var FX = $Hearts

#Take Hit
func _on_stats_you_died_signal():
	FX.emitting = true  # start particle effect
	$AnimationPlayer.play("Open")
