extends Control

@onready var transition = $transition_screen

func _ready():
	$CanvasLayer/MenuUI/VBoxContainer/Play.grab_focus()


func _on_next_level_pressed() -> void:
	$Click.play()
	transition.play("fade_out")
	$CanvasLayer.visible = false
	await transition.animation_finished
	get_tree().change_scene_to_file("res://Prefabs/level_2_tik_tok_ground.tscn")


func _on_quit_pressed() -> void:
	$Click.play()
	transition.play("fade_out")
	$CanvasLayer.visible = false
	await transition.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")
