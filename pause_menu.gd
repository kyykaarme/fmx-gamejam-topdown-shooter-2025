extends CanvasLayer
func _on_PauseButton_pressed():
	get_tree().change_scene("res://levels/node_3d.tscn")

func _on_ContinueButton_pressed():
	get_tree().change_scene("res://.tscn")
	
func _on_QuitButton_pressed():
	get_tree().change_scene("res://menu_ui.tscn")
