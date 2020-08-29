extends Node

signal freeze_time()


var gravity:=800

var map_freeze:=false
var player_freeze:=false

onready var plr=get_tree().get_root().get_node(get_tree().current_scene.name).get_node("Player")

func freeze_time():
	emit_signal("freeze_time")
	map_freeze=!map_freeze#connect("freeze_time",player,"freeze_time")
	SlowTime.start()
	plr.freeze_time()

func _physics_process(delta):
	plr=get_tree().get_root().get_node(get_tree().current_scene.name).get_node("Player")
	
	if Input.is_key_pressed(KEY_0):
		get_tree().reload_current_scene()
	
# ///

func swap(ar:Array):
	var x=ar[0]
	var y=ar[1]
	var aux=x
	x=y
	y=aux
	
	


