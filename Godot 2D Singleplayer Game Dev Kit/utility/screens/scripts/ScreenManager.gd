# this class manages transitions between Start, Game, and Win screens
# Godot runs this scenes as its main scene
# that can be changed by going to Project->ProjectSettings->Run
extends Node2D


# stores references to scene files for Start, Game, and Win screen
# changing the locations of these scenes must be reflected here
const START_SCREEN_SCENE := preload("res://utility/screens/StartScreen.tscn")
const TUTORIAL_SCREEN_SCENE := preload("res://utility/screens/TutorialScreen.tscn")
const GAME_SCREEN_SCENE := preload("res://utility/screens/GameScreen.tscn")
const FAIL_SCREEN_SCENE := preload("res://utility/screens/FailScreen.tscn")
const WIN_SCREEN_SCENE := preload("res://utility/screens/WinScreen.tscn")


# stores the current screen's PackedScene
var current_scene : PackedScene = null

# stores the current screen instance
var current_screen : Node2D = null


# goes to start screen upon starting game executable
func _ready():
	go_to_start_screen()


# called whenever user makes an input
func _input(_event:InputEvent):
	if Input.is_action_just_pressed("start"):
		match(current_scene):
			START_SCREEN_SCENE:
				go_to_tutorial_screen()
			TUTORIAL_SCREEN_SCENE:
				go_to_game_screen()
			GAME_SCREEN_SCENE:
				pass # do nothing
			FAIL_SCREEN_SCENE:
				go_to_tutorial_screen()
			WIN_SCREEN_SCENE:
				go_to_tutorial_screen()


# called when game lost/failed
func _game_failed():
	go_to_fail_screen()


# called when game won
func _game_won():
	go_to_win_screen()


# frees current screen then opens start screen
func go_to_start_screen():
	set_current_screen(START_SCREEN_SCENE)


# frees current screen then opens tutorial/controls screen
func go_to_tutorial_screen():
	set_current_screen(TUTORIAL_SCREEN_SCENE)


# frees current screen then opens game screen
func go_to_game_screen():
	set_current_screen(GAME_SCREEN_SCENE)
	
	# connect current screen to _game_won method
	current_screen.connect("game_failed", self, "_game_failed")
	current_screen.connect("game_won", self, "_game_won")


# frees current screen then opens fail screen
func go_to_fail_screen():
	set_current_screen(FAIL_SCREEN_SCENE)


# frees current screen then opens win screen
func go_to_win_screen():
	set_current_screen(WIN_SCREEN_SCENE)


# set current screen to instance of scene
func set_current_screen(scene:PackedScene):
	# free current screen
	free_current_screen()
	
	# stores scene
	current_scene = scene
	
	# instances screen
	current_screen = scene.instance()
	
	# adds screen to tree
	call_deferred("add_child", current_screen)


# frees current screen from memory if there is one
func free_current_screen():
	if is_instance_valid(current_screen):
		current_screen.call_deferred("queue_free")
	
	current_scene = null
	current_screen = null

