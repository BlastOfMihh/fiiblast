extends StateMachine

func _ready():
	add_state("idle")
	state=states.idle
	add_state("fall")
	add_state("chase")
	add_state("time_freeze")
	add_state("barrel")

var reset_anim_position:=Vector2()


func state_logic(delta): #handle the logic i guess
	if state==states["chase"]:
		parent.handle_chase(delta)
#	if state==states.idle:
#		parent.velocity=reset_anim_position
	parent.apply_gravity(delta)
	parent.apply_movement(delta)
	
	parent.get_node("RichTextLabel").text=states.keys()[state]

func get_transition(delta): #determining transitions
	match state:
		states.idle:
			if parent.player_detected:
				return states.chase
		states.chase:
			if parent.player_in_range==false :
				if parent.velocity.y!=0:
					return states.fall
				if parent.velocity.y==0:
					return states.idle
	return null



func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			##
			reset_anim_position=parent.position
			parent.get_parent().position=parent.global_position
			
			#
			parent.get_node("animationPlayer").play("patrol")


func exit_state(old_state, new_state):
	match old_state:
		states.idle:
			parent.get_node("animationPlayer").play("none")
		states.chase:
			parent.velocity.x=0













