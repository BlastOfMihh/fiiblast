extends KinematicBody2D

const SLOPE_STOP:=64
var gravity:=Globals.gravity
var velocity:=Vector2()

var speed=180
var max_jump=-200
var jumps:=0

var on_ground:=false
var on_wall:=0
onready var player=get_tree().get_root().get_node("level").get_node("PLAYER")

func _physics_process(delta):
	apply_gravity(delta)
	apply_movement(delta)
#	print(player.position)
	handle_chase(delta)


func apply_movement(delta):
	if is_on_floor():
		on_ground=true
		jumps=1
	if is_on_wall():
		on_wall=1
	velocity=move_and_slide(velocity,Vector2.UP,SLOPE_STOP)

func apply_gravity(delta):
	velocity.y+=gravity*delta

func handle_chase(delta):
	
	if velocity.y!=0:
		jumps=0
	var dir=0
	if player.position.x > self.position.x:
		dir=1
	elif player.position.x < self.position.x:
		dir=-1
	move(dir, delta)
	if player.position.y<position.y:
		print(jumps)
		if jumps>=1:
			jump(delta)

func jump(delta):
	velocity.y+=max_jump

func move(dir, delta):
	velocity.x=speed*dir
#living this,living this
