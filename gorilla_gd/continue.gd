extends Button



func _on_continue_pressed():
	get_tree().paused = false 
	get_parent().visible = false
