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

############################## SENSE ##############################

func get_sense_direction()->Vector2:
	return Vector2.ZERO


#func get_sense_direction()->int:
#	return 0


func get_sense_sprint()->bool:
	return false


#func get_sense_jump()->bool:
#	return false


func get_sense_interact()->bool:
	return false

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
	var sense_direction := get_sense_direction()
	
	_move(delta, sense_direction, get_sense_sprint())
#	_move(delta, sense_direction, get_sense_sprint(), get_sense_jump())
	_look(sense_direction)
	
	if get_sense_interact():
		_interact(sense_direction)


func _process_dead_state(_delta:float):
	pass

############################## END ##############################

