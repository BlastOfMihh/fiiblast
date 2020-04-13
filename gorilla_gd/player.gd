extends KinematicBody2D

const SLOPE_STOP:=64

var speed=200
var max_jump=-420
var min_jump=-150

var normal_gravity:=Globals.gravity
var wall_gravity:=300

var on_ground:=false
var on_wall:=0

var velocity:=Vector2()
var gravity=normal_gravity

onready var anim=$body/AnimatedSprite
onready var body=$body
#no _physiscs_process

func check_on_ground():
	for ray in $ground_rays.get_children():
		if ray.is_colliding(): return true
	return false
func check_on_wall():
	for ray in $wall_rays_left.get_children():
		if ray.is_colliding(): return -1
	for ray in $wall_rays_right.get_children():
		if ray.is_colliding(): return 1
	return 0

func apply_gravity(delta):
	velocity.y+=gravity*delta

func apply_movement(delta): 
	velocity = move_and_slide(velocity,Vector2.UP,SLOPE_STOP)
	on_ground=check_on_ground()
	on_wall=check_on_wall()

func handle_wall_jump_input():
	if Input.is_action_just_pressed("move_up"):
		velocity.y=max_jump
		velocity.x=lerp(velocity.x, 20*speed*on_wall, 0.6)
	if Input.is_action_just_released("move_up") and velocity.y<min_jump:
		velocity.y=min_jump

func handle_jump_input():
	if Input.is_action_just_pressed("move_up") and on_ground:
		velocity.y=max_jump
	
	if Input.is_action_just_released("move_up") and velocity.y<min_jump:
		velocity.y=min_jump

func handle_move_input():
	var move_x=int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left")) 
	velocity.x= lerp(velocity.x, move_x*speed, 0.8)
	anim.frames


func _on_AnimatedSprite_animation_finished():
	anim_playing=false


## if playing animations
var anim_playing:=false
var prev_anim
func _physics_process(delta):
	if anim.animation!=prev_anim:
		anim_playing=true
	prev_anim=anim.animation
###






