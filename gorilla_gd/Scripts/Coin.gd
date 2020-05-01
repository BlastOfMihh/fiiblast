extends Area2D


export var next="res://Levels/Main.tscn"




func _on_Coin_body_entered(body):
	get_tree().change_scene(next)
