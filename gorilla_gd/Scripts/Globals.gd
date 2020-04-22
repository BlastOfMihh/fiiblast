extends Node

var gravity:=800

var map_freeze:=false
var player_freeze:=false
func _physics_process(delta):
	if Input.is_action_just_pressed("freeze_map"):
		map_freeze=!map_freeze
	if Input.is_key_pressed(KEY_0):
		get_tree().reload_current_scene()
	
