extends Button





func _on_home_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false
