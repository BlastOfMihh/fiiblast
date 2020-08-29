extends ColorRect

func _process(delta):
	if get_tree().paused == true :
		visible = true

	else : visible = false
