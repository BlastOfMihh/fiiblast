extends AnimatedSprite

func _process(delta): 
	if input.is_action_pressed ("esc") :
		visible = true
