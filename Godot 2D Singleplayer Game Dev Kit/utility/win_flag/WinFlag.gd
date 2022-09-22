extends Area2D


signal player_captured_flag


func _on_WinFlag_body_entered(_body:CollisionObject2D):
	emit_signal("player_captured_flag")
