extends Button

onready var an=get_parent().get_parent().get_node("AnimationPlayer")

func _on_continue_pressed():
	get_tree().paused = false
	#get_parent().get_parent().visible=!get_parent().get_parent().visible
	an.play_backwards("appear")
	get_parent().get_parent().ac=!get_parent().get_parent().ac
