extends Button


export var doi=preload("res://Levels/Tutorial.tscn")


func _on_tutuoria_pressed():
	get_tree().change_scene_to(doi)
