extends KinematicBody2D


export var wall_slide_on:=false
export var freeze_duration:=10

onready var anim=$body/AnimatedSprite
onready var body=$body
onready var freeze_timer=$freeze_timer
onready var time_bar=$ui/bar

var velocity:=Vector2()

var normal_gravity:=Globals.gravity
var wall_gravity:=300
var down_gravity:=normal_gravity*3/2
var gravity=normal_gravity

var speed=300
var max_jump=-460
var min_jump=-200


var on_ground:=false
var on_wall:=0
var anim_playing:=false
var prev_anim=null
var available_grab_body=null
var grabbed_body=null
const SLOPE_STOP:=128
#no _physiscs_process

func _ready():
	freeze_timer.wait_time=freeze_duration
	freeze_timer.start()
	freeze_timer.paused=true
	
	$green_grad.visible=true
	$animation_player.play("turn_tf")
	$animation_player.play_backwards("turn_tf")


func check_on_ground():
	for ray in $ground_rays.get_children():
		if ray.is_colliding(): 
			return true
	return false

func check_on_wall():
	for ray in $wall_rays_left.get_children():
		if ray.is_colliding(): return -1
	for ray in $wall_rays_right.get_children():
		if ray.is_colliding(): return 1
	return 0

func apply_gravity(delta):
	velocity.y+=gravity*delta

var snap=Vector2.ZERO

func apply_movement(delta): 
	var ms=$plr_move_state
	var df=ms.states["jump"]==ms.state
	df=Input.get_action_strength("move_up")!=0
	var snap= Vector2.DOWN*8 if !df else Vector2.ZERO
	#snap=Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity,snap,Vector2.UP) #,SLOPE_STOP)
#	velocity = move_and_slide_with_snap(velocity,Vector2.UP, snap ,SLOPE_STOP)
#	velocity = move_and_slide(velocity,Vector2.UP, SLOPE_STOP)
	on_ground=check_on_ground()
	on_wall=check_on_wall()

func handle_wall_slide_input():
	if Input.is_action_just_pressed("move_up"):
		velocity.y=max_jump
		velocity.x=lerp(velocity.x, 20*speed*on_wall, 0.6)
	if Input.is_action_just_released("move_up") and velocity.y<min_jump:
		velocity.y=min_jump
	

func handle_jump_input():
#	if Input.is_action_just_pressed("move_up") and on_ground:
	if Input.get_action_strength("move_up") and on_ground:
		velocity.y=max_jump
	
	if Input.is_action_just_released("move_up") and velocity.y<min_jump:
		velocity.y=min_jump

func handle_move_input():
	var move_x=int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left")) 
	velocity.x= lerp(velocity.x, move_x*speed, 0.8)
	anim.frames



func die():
	get_tree().reload_current_scene()

func _on_grab_range_body_entered(body):
	if body.get_groups().size():
		if body.get_groups()[0]!="no_grab":
			available_grab_body=body
	else:
		available_grab_body=body
	
func _on_grab_range_body_exited(body):
	available_grab_body =null

func _on_AnimatedSprite_animation_finished():
	anim_playing=false


func _physics_process(delta):
	# if playing animations
	if anim.animation!=prev_anim:
		anim_playing=true
	prev_anim=anim.animation
	
func freeze_time():
	if !Globals.map_freeze:
		$animation_player.play_backwards("turn_tf")
	else:
		$animation_player.play("turn_tf")
	

