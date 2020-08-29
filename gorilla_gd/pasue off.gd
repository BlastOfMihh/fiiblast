extends Button



func _on_pasue_off_pressed():
	get_tree().change_scene("res://Levels/Main.tscn")
	get_tree().paused = false
