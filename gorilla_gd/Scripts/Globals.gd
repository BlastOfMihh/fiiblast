extends Node

signal freeze_time()


var gravity:=800

var map_freeze:=false
var player_freeze:=false
func _physics_process(delta):
	if Input.is_action_just_pressed("freeze_map"):
		emit_signal("freeze_time")
		map_freeze=!map_freeze
		var player=get_tree().get_root().get_node(get_tree().current_scene.name).get_node("Player")
		connect("freeze_time",player,"freeze_time")
		#.get_node("Player")
	if Input.is_key_pressed(KEY_0):
		get_tree().reload_current_scene()
	
# ///

