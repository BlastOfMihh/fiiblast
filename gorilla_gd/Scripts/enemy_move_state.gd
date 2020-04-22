extends StateMachine

func _ready():
	add_state("idle")
	state=states.idle
	add_state("run")
	add_state("jump")
	add_state("fall")
	
	add_state("time_freeze")
	add_state("grabbed")

func state_logic(delta): #handle the logic i guess
	
	if Globals.map_freeze==false:
		parent.apply_gravity(delta)
		parent.apply_movement(delta)
		
	parent.get_node("move_text").text=states.keys()[state]

func get_transition(delta): #determining transitions
	
	match state:
		states.idle:
			if parent.velocity.y<0:
				return states.jump
			if parent.velocity.x!=0:
				return states.run
			if parent.velocity.y>0:
				return states.fall
		states.run:
			if parent.velocity.y<0:
				return states.jump
			if parent.velocity==Vector2.ZERO:
				return states.idle
		states.jump:
			if parent.velocity.y>0:
				return states.fall
			if parent.velocity.y==0:
				return states.idle
		states.fall:
			if parent.velocity==Vector2.ZERO:
				return states.idle
	return null

func enter_state(new_state, old_state):
	pass
func exit_state(old_state, new_state):
	pass












