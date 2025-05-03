extends Control

func _ready():
	$CanvasLayer/MenuUI/VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/Main.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://credits.tscn")
