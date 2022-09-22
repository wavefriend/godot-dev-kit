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


# frees current screen from memory if there is one
func free_current_screen():
	if is_instance_valid(current_screen_node):
		current_screen_node.call_deferred("queue_free")
	
	current_screen_name = ""
	current_screen_scene = null
	current_screen_node = null

############################## END ##############################
