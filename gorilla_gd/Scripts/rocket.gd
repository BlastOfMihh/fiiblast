extends KinematicBody2D


export var dir=-1
export var speed=20
export var max_speed=2000

var velocity=Vector2.ZERO

func _physics_process(delta):
	if !Globals.map_freeze:
		move(dir,speed)
		apply_gravity(delta)
		apply_movement(delta)

func apply_movement(delta):
	velocity=move_and_slide(velocity,Vector2.UP)

func apply_gravity(delta):
	velocity.y+=Globals.gravity

func move(dir,speed):
	velocity.x=speed*dir
	velocity.x=min(velocity.x,max_speed)
