extends StateMachine

var jumps=0

func _ready():
	add_state("idle")
	state=0
	add_state("run")
	add_state("jump")
	add_state("wall_slide")
	add_state("fall")
	add_state("dance")

var prev_d=false

func state_logic(delta): #handle the logic i guess
#	if state!=states.wall_slide:
	parent.handle_move_input()
#	if [states.run, states.idle, states.fall,states.jump].has(state): 
	if 1:
		var now_d=Input.is_action_pressed("move_down")
		var ground_range=[parent]+parent.get_node("ground_rays").get_children()
		if prev_d!=now_d:
			for i in ground_range:
				i.set_collision_mask_bit(3,!i.get_collision_mask_bit(3))
		prev_d=now_d

	if [states.run,states.idle, states.jump, states.fall].has(state): 
		parent.handle_jump_input()
	elif states.wall_slide==state:
		parent.handle_wall_slide_input()
	parent.apply_gravity(delta)
	parent.apply_movement(delta)
	
	if parent.velocity.x>0:
		parent.body.scale.x=1;
	elif parent.velocity.x<0:
		parent.body.scale.x=-1;
		
	get_parent().get_node("ui").get_node("RichTextLabel").text=String(states.keys()[state])

func get_transition(delta): #determining transitions
	match state:
		states.dance:
			if parent.velocity.x!=0:
				return states.run
		states.idle:
			if Input.is_key_pressed(KEY_B):
				return states.dance
			if parent.velocity.y<0 and Input.is_action_pressed("move_up"):
				return states.jump
			if abs(parent.velocity.y)!=0 and parent.on_ground==false:
				print("sup")
				return states.fall
			if parent.velocity.x!=0 and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
				return states.run
		states.run:
			if parent.velocity.y<0 and Input.is_action_pressed("move_up"):
				return states.jump
			if parent.velocity.y>0 and parent.on_ground==false:
				return states.fall
			if abs(parent.velocity.x)<1:
				return states.idle
		states.wall_slide:
			
			if !parent.on_wall or parent.velocity.x!=0 and Input.is_action_pressed("move_up"):
				return states.jump
			if parent.on_ground:
				return states.idle
		states.jump:
			
			if parent.on_ground:
				return states.idle
			if parent.velocity.y>0 and parent.on_ground==false:
				return states.fall
			if parent.on_wall and parent.wall_slide_on:
				return states.wall_slide
		states.fall:
			
			if parent.on_ground:
				if parent.velocity.x==0:
					return states.idle
				else :
					return states.run
			if parent.velocity.y<=0:
				return states.jump
			if parent.on_wall and parent.wall_slide_on:
				return states.wall_slide
#	print(state)
	return null
	
func enter_state(new_state, old_state):
	if parent.anim.animation!="attack" or !parent.anim_playing:
		match new_state:
			states.dance:
				
				parent.anim.play("dance")
			states.idle:
				parent.anim.play("idle")
			states.jump:
				parent.anim.play("jump")
			states.run:
				parent.anim.play("run")
			states.fall:
				parent.anim.play("jump")
			states.wall_slide:
				parent.anim.play("wall_slide")
				parent.gravity=parent.wall_gravity
				parent.velocity.y=-12

func exit_state(old_state, new_state):
	if old_state==states.wall_slide:
		parent.gravity=parent.normal_gravity
#j'en ai merre
#totusi exista iubire
#it's got to be perfect
