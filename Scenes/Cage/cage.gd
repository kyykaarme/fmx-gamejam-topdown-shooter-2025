extends Node3D


@onready var FX = $Hearts

#Take Hit
func _on_stats_you_died_signal():
	FX.emitting = true  # start particle effect
	$CageCylinder007.visible = false
	await get_tree().create_timer(1.5).timeout  # wait 0.5 seconds
	queue_free()
