extends Node2D


signal game_failed
signal game_won


# called when game failed in Game.tscn
# relays signal up to ScreenManager
func _game_failed():
	emit_signal("game_failed")


# called when game won in Game.tscn
# relays signal up to ScreenManager
func _game_won():
	emit_signal("game_won")



