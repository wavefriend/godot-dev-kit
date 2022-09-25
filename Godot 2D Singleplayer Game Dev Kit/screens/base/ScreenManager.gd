extends Node2D

############################## CONSTANTS ##############################

const SCREEN_SCENES := {
	"start":preload("res://screens/StartScreen.tscn"),
	"credits":preload("res://screens/CreditsScreen.tscn"),
	"story":preload("res://screens/StoryScreen.tscn"),
	"tutorial":preload("res://screens/TutorialScreen.tscn"),
	"game":preload("res://screens/GameScreen.tscn"),
	"fail":preload("res://screens/FailScreen.tscn"),
	"win":preload("res://screens/WinScreen.tscn")
}

############################## ONREADYS ##############################

onready var intro_music := $Music/IntroMusic
onready var fail_music := $Music/FailMusic
onready var win_music := $Music/WinMusic

############################## VARIABLES ##############################

# stores string name of scene
var current_screen_name := ""

# stores the current screen's PackedScene
var current_screen_scene : PackedScene = null

# stores the current screen instance
var current_screen_node : Node = null

############################## EVENTS ##############################

# goes to start screen upon starting game executable
func _ready():
	set_current_screen("start")


# called whenever user makes an input
func _input(_event:InputEvent):
	if Input.is_action_just_pressed("continue"):
		match(current_screen_name):
			"start":
				set_current_screen("story")
			"credits":
				set_current_screen("start")
			"story":
				set_current_screen("tutorial")
			"tutorial":
				set_current_screen("game")
			"fail":
				set_current_screen("tutorial")
			"win":
				set_current_screen("tutorial")
	
	elif Input.is_action_just_pressed("alternate"):
		match(current_screen_name):
			"start":
				set_current_screen("credits")
			"credits":
				set_current_screen("start")

############################## METHODS ##############################

# set current screen to instance of scene
func set_current_screen(screen_name:String, data:={}):
	# free current screen
	free_current_screen()
	
	# store screen name
	current_screen_name = screen_name
	
	# stores scene
	current_screen_scene = SCREEN_SCENES[screen_name]
	
	# instances screen
	current_screen_node = current_screen_scene.instance()
	
	# connect screen change signal
	current_screen_node.connect("screen_change_requested", self, "set_current_screen")
	
	# adds screen to tree
	call_deferred("add_child", current_screen_node)
	
	# call after screen node added to tree
	current_screen_node.call_deferred("init", data)
	
	# update music
	_update_music(screen_name)


# frees current screen from memory if there is one
func free_current_screen():
	if is_instance_valid(current_screen_node):
		current_screen_node.call_deferred("queue_free")
	
	current_screen_name = ""
	current_screen_scene = null
	current_screen_node = null

############################## MUSIC ##############################

func _update_music(screen_name:String):
	match(screen_name):
		"start":
			fail_music.stop()
			win_music.stop()
			if not intro_music.is_playing():
				intro_music.play()
		"game":
			intro_music.stop()
			fail_music.stop()
			win_music.stop()
		"fail":
			intro_music.stop()
			win_music.stop()
			if not fail_music.is_playing():
				fail_music.play()
		"win":
			intro_music.stop()
			fail_music.stop()
			if not win_music.is_playing():
				win_music.play()

############################## END ##############################
