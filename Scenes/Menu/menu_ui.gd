extends Control

@onready var transition = $transition_screen
@onready var Sound = $Click

func _ready():
	$CanvasLayer/MenuUI/VBoxContainer/Play.grab_focus()

func _on_play_pressed():
	Sound.play()
	transition.play("fade_out")
	$CanvasLayer.visible = false
	await transition.animation_finished
	get_tree().change_scene_to_file("res://levels/Level1_Facebook.tscn")


func _on_credits_pressed():
	Sound.play()
	transition.play("fade_out")
	$CanvasLayer.visible = false
	await transition.animation_finished
	get_tree().change_scene_to_file("res://Credits.tscn")
