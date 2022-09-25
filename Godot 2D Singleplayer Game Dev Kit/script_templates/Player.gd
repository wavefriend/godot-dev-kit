extends KinematicBody2D

############################## EXPORTS ##############################

export(float) var move_speed := 128.0 # pixels / sec

############################## VARIABLES ##############################

enum STATE {ALIVE, DEAD}
var state : int = STATE.ALIVE

var velocity := Vector2.ZERO

############################## INIT ##############################

func _ready():
	_enter_alive_state()

############################## PROCESS ##############################

func _physics_process(delta:float):
	match(state):
		STATE.ALIVE:
			_process_alive_state(delta)
		STATE.DEAD:
			_process_dead_state(delta)

############################## INPUT ##############################

func get_input_direction()->Vector2:
	var x := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var y := int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return Vector2(x,y).normalized()


#func get_input_direction()->int:
#	var x := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
#	return x


func get_input_sprint()->bool:
	return Input.is_action_pressed("sprint")


#func get_input_jump()->bool:
#	return Input.is_action_just_pressed("jump")


func get_input_interact()->bool:
	return Input.is_action_just_pressed("interact")

############################## MOTION ##############################

func _move(_delta:float, direction:=Vector2.ZERO, sprint:=false):
	velocity = move_and_slide(move_speed * direction.normalized())


#func _move(_delta:float, direction:=0, sprint:=false, jump:=false):
#	velocity = move_and_slide(move_speed * direction * Vector2.RIGHT)


func _look(direction:=Vector2.ZERO):
	if direction.length_squared() > 0.0:
		rotation = direction.angle()


#func _look(direction:=0):
#	if abs(direction) > 0.0:
#		scale.x = direction

############################## ACTION ##############################

func _interact(direction:=Vector2.ZERO):
	pass


#func _interact(direction:=0):
#	pass

############################## STATE ##############################

func _enter_alive_state():
	pass


func _enter_dead_state():
	pass


func _process_alive_state(delta:float):
	var input_direction := get_input_direction()
	
	_move(delta, input_direction, get_input_sprint())
#	_move(delta, input_direction, get_input_sprint(), get_input_jump())
	_look(input_direction)
	
	if get_input_interact():
		_interact(input_direction)


func _process_dead_state(_delta:float):
	pass

############################## END ##############################

