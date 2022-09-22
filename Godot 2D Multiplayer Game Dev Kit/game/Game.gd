# this script and correspond scene is where all the actual gameplay takes place
# ScreenManager transitions the user in and out of this scene when game starts/ends
extends Node2D


signal game_won # emits winner as string


# stores whether game has ended
var has_game_ended := false


# YOU MUST MANUALLY CALL THIS METHOD to end the game, specify winner as a string
# you will most likely use a signal from an object like win flag or clock to do this
func end_game(winner:String):
	# prevent game session from being ended twice
	if has_game_ended:
		return
	
	# remember that game has ended
	has_game_ended = true
	
	# notify parent node that game has been won by winner
	emit_signal("game_won", winner)

