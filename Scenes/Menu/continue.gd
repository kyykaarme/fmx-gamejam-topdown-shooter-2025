extends Control

@onready var transition = $transition_screen

func _ready():
	$CanvasLayer/MenuUI/VBoxContainer/Play.grab_focus()


func _on_quit_pressed() -> void:
	transition.play("fade_out")
	get_tree().change_scene_to_file("res://Scenes/Menu/main_menu.tscn")


func _on_continue_pressed() -> void:
	transition.play("fade_out")
	get_tree().paused = false
	visible = false
