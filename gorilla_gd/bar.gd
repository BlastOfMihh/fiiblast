extends Sprite

onready var parent=get_parent().get_parent()

var normal_size_x=scale.x

func _process(delta):
	scale.x=normal_size_x*parent.freeze_timer.time_left/parent.freeze_timer.wait_time

