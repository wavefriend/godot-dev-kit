# Topdowner script
# This is a top down character with 8 directional movement
extends KinematicBody2D


# store movement parameters
# export means that their values can be set in the Inspector
export(float) var move_speed := 128.0 # units of pixels / sec

# stores the current velocity of this object as a vector
var velocity := Vector2.ZERO


# this method is called when object first created
func _ready():
	pass


# this method is called every physics frame
func _physics_process(delta:float):
	move(delta, get_input_direction())


# move in direction at move speed
func move(_delta:float, direction:=Vector2.ZERO):
	# determine velocity from direction and speed
	velocity = move_speed * direction.normalized()
	
	# move object based on velocity
	velocity = move_and_slide(velocity)


# return direction indicated by keyboard input (i.e. WASD or arrow keys) as normalized 2d vector
func get_input_direction()->Vector2:
	# determines when left/right up/down are pressed
	var x := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var y := int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	# ensure movement direction is of unit 1 length so that diagonal motion isnt faster than lateral
	return Vector2(x, y).normalized()


# this method is called by bullet when character is hit by bullet
func hit():
	# changes color from blue to red
	modulate.r += .1
	modulate.b -= .1

