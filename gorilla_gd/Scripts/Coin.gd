extends Area2D


export var next="res://Levels/level1.tscn"




func _on_Coin_body_entered(body):
	if body.name=="Player" and Globals.map_freeze==false:
		get_tree().change_scene(next)
