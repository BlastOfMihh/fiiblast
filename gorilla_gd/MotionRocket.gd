extends KinematicBody2D


export var speed:=2

var velocity:=Vector2.ZERO
var it:=Vector2.ZERO

func apply_chase():
	it=(Globals.plr.global_position - self.global_position).normalized()
	self.rotation=PI-atan2(it.x,it.y) + PI/2#+ deg2rad(12.5)
	velocity+=it*speed


func _physics_process(delta):
	apply_chase()
	velocity=move_and_slide(velocity,Vector2.UP)
