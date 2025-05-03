extends CanvasLayer
func _on_PlayButton_pressed():
	get_tree().change_scene("res://levels/Main.tscn")

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://settings.tscn")

func _on_CreditsButton_pressed():
	get_tree().change_scene("res://credits.tscn")
