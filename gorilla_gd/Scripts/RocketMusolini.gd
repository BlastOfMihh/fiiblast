extends KinematicBody2D

export var detect_radius=23
export var in_range_radius=40

func _ready():
	$in_range/CollisionShape2D.shape.radius=in_range_radius
	$player_detect/CollisionShape2D.shape.radius=detect_radius

var velocity:=Vector2()

onready var rocket_preload=preload("res://MotionRocket.tscn")

onready var plr:=get_tree().get_root().get_node(get_tree().current_scene.name).get_node("Player")
onready var move_state=$enemy_move_state
onready var action_state=$enemy_action_state
onready var anim=$sprite
onready var attack_timer=$attack_timer
onready var cooldown_timer=$coolddown_timer
onready var rocket_position=$rocket_position

const SLOPE_STOP:=64
var gravity:=Globals.gravity
var speed=120
var max_jump=-130
var max_jump_count:=1
var jump_count:=0

var plr_in_range:=false
var on_ground:=false
var on_wall:=0


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

func spawn_rocket():
	var rocket_instance=rocket_preload.instance()
	rocket_instance.position=self.rocket_position.postion
	get_parent().add_child(rocket_instance)
	
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

