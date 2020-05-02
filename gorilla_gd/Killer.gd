extends Area2D



signal kill

func _on_Area2D_body_entered(body):
	if !Globals.map_freeze and body.name=="Player":
		connect("kill",Globals.plr,"die")
		emit_signal("kill")
