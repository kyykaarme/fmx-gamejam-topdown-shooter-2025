extends Node3D

@onready var FX = $Hearts
@onready var anim_player = $AnimationPlayer

func _on_stats_you_died_signal():
	FX.emitting = true  # start particle effect

	anim_player.play("Open")
	await anim_player.animation_finished
	queue_free()
