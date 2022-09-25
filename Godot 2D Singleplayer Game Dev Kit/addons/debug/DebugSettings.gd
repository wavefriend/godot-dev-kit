extends Node

############################## VARIABLES ##############################

var rng := RandomNumberGenerator.new()

############################## INIT ##############################

func _ready():
	rng.randomize()

############################## DEBUG ##############################

func _input(_event:InputEvent):
	if OS.is_debug_build(): # remove this condition if you'd like to access these commands in non-debug builds
		if Input.is_action_just_pressed("debug_exit"):
			exit()
		elif Input.is_action_just_pressed("debug_restart"):
			restart()
		elif Input.is_action_just_pressed("debug_screenshot"):
			screenshot()
		elif Input.is_action_just_pressed("debug_fullscreen"):
			fullscreen()

############################## METHODS ##############################

func exit():
	get_tree().quit()


func restart():
	get_tree().reload_current_scene()


func screenshot():
	var image = get_viewport().get_texture().get_data().flip_y()
	var path = "res://screenshots/" + str(rng.randi()) + ".png"
	image.save_png(path)
	print(path + " saved!")


func fullscreen():
	OS.window_fullscreen = not OS.window_fullscreen

############################## END ##############################
