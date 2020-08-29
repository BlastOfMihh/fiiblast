extends Button




func _on_pasue_off_pressed():
	get_tree().change_scene()
	visible = false
	get_tree().paused = false
