extends Button

export var doi=preload("res://Levels/Tutorial.tscn")

func _on_paly_pressed():
	print(23)
	get_tree().change_scene_to(doi)
