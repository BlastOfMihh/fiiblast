extends Button


extends Button




func _on_Button_pressed():
	get_tree().reload_current_scene()
	get_parent().visible = false
	get_tree().pause = false
