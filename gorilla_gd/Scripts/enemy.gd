extends KinematicBody2D

export var detect_radius=23
export var in_range_radius=40

func _ready():
	$in_range/CollisionShape2D.shape.radius=in_range_radius
	$player_detect/CollisionShape2D.shape.radius=detect_radius


signal kill

const SLOPE_STOP:=64
var gravity:=Globals.gravity
var velocity:=Vector2()

var speed=120
var max_jump=-130
var max_jump_count:=1
var jump_count:=0

var on_ground:=false
var on_wall:=0

onready var plr:=get_tree().get_root().get_node(get_tree().current_scene.name).get_node("Player")

onready var move_state=$enemy_move_state
onready var action_state=$enemy_action_state
onready var anim=$sprite

var plr_in_range:=false



func apply_movement(delta):

	on_ground=is_on_floor()
	if on_ground:
		jump_count=0
	on_wall=is_on_wall()
	velocity=move_and_slide(velocity,Vector2.UP,SLOPE_STOP)

func apply_gravity(delta):
	velocity.y+=gravity*delta

func jump(delta):
	if jump_count<max_jump_count:
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
	if !Globals.map_freeze:
		if body ==plr:
			plr_in_range=true
			$player_detect.monitoring=false
			$in_range.monitoring=true

func _on_range_body_exited(body):
	if !Globals.map_freeze:
		if body==plr:
			plr_in_range=false
			$player_detect.monitoring=true
			$in_range.monitoring=false



func _on_Area2D_body_entered(body):
	if !Globals.map_freeze and body.name=="Player":
		connect("kill",plr,"die")
		emit_signal("kill")
