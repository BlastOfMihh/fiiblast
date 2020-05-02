extends StaticBody2D



func _on_Area2D_area_exited(area):
	$CollisionShape2D.disabled=false
	$sprite_0.visible=true
