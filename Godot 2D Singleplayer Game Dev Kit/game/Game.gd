extends Node2D

############################## SIGNALS ##############################

signal game_failed(screen_name, data)
signal game_won(screen_name, data)

############################## CONSTANTS ##############################

const FAIL_DELAY_TIME := 2.0
const WIN_DELAY_TIME := 2.0

############################## VARIABLES ##############################

# stores whether game has ended
var has_game_ended := false

############################## METHODS ##############################

# this must be manually called by child class or via signal
func fail_game(data:={}):
	# prevent game session from being ended twice
	if has_game_ended:
		return
	
	# remember that game has ended
	has_game_ended = true
	
	# yield an amount of time
	yield(get_tree().create_timer(FAIL_DELAY_TIME), "timeout")
	
	# notify parent node that game has been lost
	emit_signal("game_failed", "fail", data)


# this must be manually called by child class or via signal
func win_game(data:={}):
	# prevent game session from being ended twice
	if has_game_ended:
		return
	
	# remember that game has ended
	has_game_ended = true
	
	# yield an amount of time
	yield(get_tree().create_timer(WIN_DELAY_TIME), "timeout")
	
	# notify parent node that game has been won
	emit_signal("game_won", "win", data)

############################## DEBUG ##############################

func _input(_event:InputEvent):
	if OS.is_debug_build():
		if Input.is_action_just_pressed("debug_fail"):
			fail_game()
		elif Input.is_action_just_pressed("debug_win"):
			win_game()

############################## END ##############################

