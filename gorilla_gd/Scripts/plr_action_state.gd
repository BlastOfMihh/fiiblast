extends StateMachine

func _ready():
	add_state("none")
	state=states.none
	add_state("attack")
	add_state("hold")
	

func state_logic(delta): #handle the logic i guess
	parent.get_node("RichTextLabel2").text=states.keys()[state]

func get_transition(delta): #determining transitions
	match state:
		states.none:
			if Input.is_action_just_pressed("grab"):
				return states.hold
			
			if false and Input.is_action_just_pressed("attack"):#disabeling attack
				return states.attack
		states.attack:
			if parent.anim.animation=="attack" and parent.anim_playing==false:
				return states.none
	return null
	
func enter_state(new_state, old_state):
	match new_state:
		states.hold:
			
			pass
		states.attack:
			parent.anim.play("attack")

func exit_state(old_state, new_state):
	pass
	
