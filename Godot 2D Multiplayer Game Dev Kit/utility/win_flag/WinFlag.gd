extends Area2D


signal player_captured_flag # emits player name


func _on_WinFlag_body_entered(body:CollisionObject2D):
	emit_signal("player_captured_flag", body.name)
