extends Node

const END_VALUE=1

var is_active:=false
var time_start
var duration_ms

var start_value

func start(duration = 1.2, strength=.8):
	time_start=OS.get_ticks_msec()
	duration_ms = duration * 1000
	start_value = 1-strength
	Engine.time_scale = start_value
	is_active=true

func _process(delta):
	if is_active:
		var current_rime = OS.get_ticks_msec()-time_start
		var value=circl_ease_in(current_rime,start_value,END_VALUE,duration_ms)
		if current_rime>=duration_ms:
			is_active=false
			value=END_VALUE
		Engine.time_scale=value

# t  current rime
# b  start value
# c: end value
# d: duration

func circl_ease_in(t, b, c, d):
	t/=d
	return -c*(sqrt(1-t*t)-1) + b



