###################################################################
# this file is an autoload (a script that always runs in the background)
# it checks to see if the player pressed the exit, restart, screenshot, or fullscreen buttons
# none of those button presses will work if the project is not a debug build
# go to Project->ProjectSettings->InputMap to change keybindings for debug buttons
###################################################################

# Autoload Settings
extends Node

var rng := RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _input(event:InputEvent):
	if OS.is_debug_build(): # remove this condition if you'd like to access these commands in non-debug builds
		if Input.is_action_just_pressed("debug_exit"):
			exit()
		if Input.is_action_just_pressed("debug_restart"):
			reset()
		if Input.is_action_just_pressed("debug_screenshot"):
			screenshot()
		if Input.is_action_just_pressed("debug_fullscreen"):
			fullscreen()


func exit():
	get_tree().quit()


func reset():
	get_tree().reload_current_scene()


func screenshot():
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	var path = "res://screenshots/" + str(rng.randi()) + ".png"
	print(path + " saved!")
	image.save_png(path)


func fullscreen():
	OS.window_fullscreen = not OS.window_fullscreen

