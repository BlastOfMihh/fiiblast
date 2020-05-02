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
		if parent.velocity.x>0:
			parent.anim.flip_h=1
			parent.rocket_position.position.x=+abs(parent.rocket_position.position.x)
		elif parent.velocity.x<0:
			parent.anim.flip_h=0
			parent.rocket_position.position.x=-abs(parent.rocket_position.position.x)
		
	parent.get_node("move_text").text=states.keys()[state]

func get_transition(delta): #determining transitions
	if !Globals.map_freeze:
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
				if parent.velocity.y==0:
					return states.run
				if parent.velocity==Vector2.ZERO:
					return states.idle
	return null

func enter_state(new_state, old_state):
	if parent.rocket_anim_playing==false:
		match new_state:
			states.idle:
				parent.anim.play("idle")
			states.run:
				parent.anim.play("run")
			states.jump:
				parent.anim.play("jump")
			states.fall:
				parent.anim.play("fall")
		
		
func exit_state(old_state, new_state):
	pass












