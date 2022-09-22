# this script and correspond scene is where all the actual gameplay takes place
# ScreenManager transitions the user in and out of this scene when game starts/ends
extends Node2D


signal game_failed
signal game_won


# stores whether game has ended
var has_game_ended := false


# YOU MUST MANUALLY CALL THIS METHOD to end the game
# you will most likely use a signal from the death of the player object to call this
func fail_game():
	# prevent game session from being ended twice
	if has_game_ended:
		return
	
	# remember that game has ended
	has_game_ended = true
	
	# notify parent node that game has been lost
	emit_signal("game_failed")


# YOU MUST MANUALLY CALL THIS METHOD to end the game
# you will most likely use a signal from an object like win flag or clock to do this
func win_game():
	# prevent game session from being ended twice
	if has_game_ended:
		return
	
	# remember that game has ended
	has_game_ended = true
	
	# notify parent node that game has been won
	emit_signal("game_won")


