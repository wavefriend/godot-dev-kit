# this class manages transitions between Start, Game, and Win screens
# Godot runs this scenes as its main scene
# that can be changed by going to Project->ProjectSettings->Run
extends Node2D


# stores references to scene files for Start, Game, and Win screen
# changing the locations of these scenes must be reflected here
const START_SCREEN_SCENE := preload("res://utility/screens/StartScreen.tscn")
const GAME_SCREEN_SCENE := preload("res://utility/screens/GameScreen.tscn")
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
				go_to_game_screen()
			GAME_SCREEN_SCENE:
				pass # do nothing
			WIN_SCREEN_SCENE:
				go_to_game_screen()


# called when game won, winner is provided as string
func _game_won(winner:String):
	go_to_win_screen(winner)


# frees current screen then opens start screen
func go_to_start_screen():
	set_current_screen(START_SCREEN_SCENE)


# frees current screen then opens game screen
func go_to_game_screen():
	set_current_screen(GAME_SCREEN_SCENE)
	
	# connect current screen to _game_won method
	current_screen.connect("game_won", self, "_game_won")


# frees current screen then opens win screen
func go_to_win_screen(winner:String):
	set_current_screen(WIN_SCREEN_SCENE)
	
	# tell current screen who won
	current_screen.call_deferred("set_winner", winner)

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

