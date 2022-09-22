# Platformer script
# this is a side scrolling character with jumping and gravity
extends KinematicBody2D


# store if this is the blue or red player (WASD player vs arrow key player)
# export means that their values can be set in the Inspector
enum PLAYER {BLUE, RED}
export(PLAYER) var player := PLAYER.BLUE

# store movement parameters
# export means that their values can be set in the Inspector
export(float) var move_speed := 128.0 # units of pixels / sec
export(float) var jump_speed := 300.0 # units of pixels / sec
export(float) var grav_acceleration := 500.0 # units of pixels / sec / sec

# stores the current velocity of this object as a vector
var velocity := Vector2.ZERO


# this method is called when object first created
func _ready():
	pass


# this method is called every physics frame
func _physics_process(delta:float):
	move(delta, get_input_direction(), get_input_jump())


# move in direction at move speed and/or jump at jump speed
func move(delta:float, direction:=0, jump:=false):
	# move object left / right based on input
	velocity.x = move_speed * sign(direction)
	
	# check if wants to jump and is on floor
	if jump and is_on_floor():
		velocity.y = -jump_speed
	
	# apply gravitational force
	velocity.y += grav_acceleration * delta
	
	# move object based on velocity
	velocity = move_and_slide(velocity, Vector2.UP)


# return direction indicated by keyboard input (i.e. AD or left right arrow) as int -1, 0, or 1
func get_input_direction()->int:
	# this is a dumb string math way to determine which player is controlling this character
	var player_prefix : String = PLAYER.keys()[player].to_lower() + "_"
	
	# return sign of player input direction
	return int(Input.is_action_pressed(player_prefix + "move_right")) - int(Input.is_action_pressed(player_prefix + "move_left"))


# return whether player just pressed jump key (i.e. W or up arrow)
func get_input_jump()->bool:
	# this is a dumb string math way to determine which player is controlling this character
	var player_prefix : String = PLAYER.keys()[player].to_lower() + "_"
	
	# return whether player pressed jump as boolean
	return Input.is_action_just_pressed(player_prefix + "jump")


