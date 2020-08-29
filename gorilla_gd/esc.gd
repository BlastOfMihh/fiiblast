extends Node2D

onready var an = $AnimationPlayer
var ac=false


func _process(delta):
	if Input.is_action_just_pressed("esc") :
		if ac:
			an.play_backwards("appear")
		else:
			an.play("appear")
		get_tree().paused = !get_tree().paused
		ac=!ac

