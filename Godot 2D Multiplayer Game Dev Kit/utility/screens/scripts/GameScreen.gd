extends Node2D


signal game_won # emits winner as string


# called when game ended in Game.tscn
# relays winner string up to ScreenManager
func _game_won(winner:String):
	emit_signal("game_won", winner)
