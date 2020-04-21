extends StateMachine

onready var plr=get_tree().get_root().get_node("level").get_node("PLAYER")


func _ready():
	add_state("none")
	state=0
	add_state("chase")

func state_logic(delta): #handle the logic i guess
	
	parent.get_node("action_text").text=states.keys()[state]
	if state==states.chase:
		var offset=10
		var dir=0
		if plr.global_position.y < parent.global_position.y-offset:
			parent.jump(delta)
		if plr.global_position.x > parent.global_position.x-offset:
			dir=1
		elif plr.global_position.x < parent.global_position.x-offset:
			dir=-1
		parent.move(dir,delta)

func get_transition(delta): #determining transitions
	match state:
		states.none:
			if get_parent().plr_in_range:
				return states.chase
		states.chase:
			if !get_parent().plr_in_range:
				return states.none
	return null
	
func enter_state(new_state, old_state):
	pass

func exit_state(old_state, new_state):
	match old_state:
		states.chase:
			parent.velocity.x=0
