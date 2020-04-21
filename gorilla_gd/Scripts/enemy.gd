extends KinematicBody2D

const SLOPE_STOP:=64
var gravity:=Globals.gravity
var velocity:=Vector2()

var speed=180
var max_jump=-200
var max_jump_count:=1
var jump_count:=0

var on_ground:=false
var on_wall:=0

onready var plr:=get_tree().get_root().get_node("level").get_node("PLAYER")

onready var move_state=$enemy_move_state
onready var action_state=$enemy_action_state

var plr_in_range:=false

func apply_movement(delta):
	if is_on_floor():
		on_ground=true
		jump_count=0
	if is_on_wall():
		on_wall=1
	velocity=move_and_slide(velocity,Vector2.UP,SLOPE_STOP)

func apply_gravity(delta):
	velocity.y+=gravity*delta

func jump(delta):
	if jump_count<max_jump_count:
		print("jumped")
		velocity.y+=max_jump
		jump_count+=1

func move(dir, delta):
	velocity.x=speed*dir

#func handle_chase(delta):
#	var dir=0
#	if player.global_position.x > self.global_position.x+10:
#		dir=1
#	elif player.global_position.x < self.global_position.x-10:
#		dir=-1
#	move(dir, delta)
#	if player.global_position.y<self.global_position.y:
#		jump(delta)

#signals
func _on_player_detect_body_entered(body):
	if body ==plr:
		plr_in_range=true
		$player_detect.monitoring=false
		$in_range.monitoring=true
		print("got him")

func _on_range_body_exited(body):
	if body==plr:
		plr_in_range=false
		$player_detect.monitoring=true
		$in_range.monitoring=false
		print("lost him")











