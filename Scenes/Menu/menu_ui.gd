extends Control

@onready var transition = $transition_screen

func _ready():
	$CanvasLayer/MenuUI/VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	transition.play("fade_out")
	get_tree().change_scene_to_file("res://levels/Level1_Facebook.tscn")


func _on_settings_pressed():
	transition.play("fade_out")
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_credits_pressed():
	transition.play("fade_out")
	get_tree().change_scene_to_file("res://credits.tscn")
