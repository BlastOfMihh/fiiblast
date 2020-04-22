extends StateMachine

var grab_offset=Vector2.ZERO
var grab_collison_shape=null

func _ready():
	add_state("none")
	state=states.none
	add_state("attack")
	add_state("hold")

func state_logic(delta): #handle the logic i guess
	parent.get_node("RichTextLabel2").text=states.keys()[state]
	if state==states.hold:
		parent.grabbed_body.position=parent.position+grab_offset
	

func get_transition(delta): #determining transitions
	match state:
		states.none:
			if Input.is_action_just_pressed("grab") and parent.available_grab_body!=null:
				return states.hold
			if false and Input.is_action_just_pressed("attack"):#disabeling attack
				return states.attack
		states.hold:
			if Input.is_action_just_pressed("grab") and parent.grabbed_body!=null:
				return states.none
		states.attack:
			if parent.anim.animation=="attack" and parent.anim_playing==false:
				return states.none
	return null
	
func enter_state(new_state, old_state):
	match new_state:
		states.hold:
			parent.grabbed_body=parent.available_grab_body
			grab_collison_shape=CollisionShape2D.new()
			grab_collison_shape.shape=parent.grabbed_body.get_node("collision_shape").shape
			parent.add_child(grab_collison_shape)
			grab_offset.y=-(parent.get_node("collision_shape").shape.extents.y+grab_collison_shape.shape.extents.y+1)
			
			grab_collison_shape.position=grab_offset
			grab_collison_shape.name="grab_shape"
			parent.grabbed_body.get_node("collision_shape").disabled=true
			parent.get_node("grab_range").monitoring=false
		states.attack:
			parent.anim.play("attack")

func exit_state(old_state, new_state):
	match old_state:
		states.hold:
			grab_collison_shape.queue_free()
			grab_collison_shape=null
			grab_offset=Vector2.ZERO
			parent.grabbed_body.get_node("collision_shape").disabled=false
			parent.grabbed_body=null
			parent.get_node("grab_range").monitoring=true
	





