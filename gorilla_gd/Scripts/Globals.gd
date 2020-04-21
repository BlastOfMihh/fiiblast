extends Node

var gravity:=800

var map_freeze:=false
var player_freeze:=false
func _physics_process(delta):
	if Input.is_action_just_pressed("freeze_map"):
		map_freeze=!map_freeze
	
	
#jeff says hi
#jeff says hi part 2