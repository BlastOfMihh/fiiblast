extends Timer

var finished:=false

func _process(delta):
	if self.time_left!=self.wait_time:
		finished=false
func _on_coolddown_timer_timeout():
	finished=true
