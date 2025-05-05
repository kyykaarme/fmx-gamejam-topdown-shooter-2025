extends CanvasLayer

@onready var transition = $transition_screen


func _on_quit_pressed() -> void:
	transition.play("fade_out")
	$CanvasLayer.visible = false
	await transition.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")


func _on_continue_pressed() -> void:
	transition.play("fade_out")
	$CanvasLayer.visible = falsewwwwww
	await transition.animation_finished
	get_tree().paused = false
	visible = false
