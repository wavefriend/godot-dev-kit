extends Node

############################## VARIABLES ##############################

enum STATE {ALIVE, DEAD}
var state : int = STATE.ALIVE

############################## INIT ##############################

func _ready():
	_enter_alive_state()

############################## PROCESS ##############################

func _process(delta:float):
	match(state):
		STATE.ALIVE:
			_process_alive_state(delta)
		STATE.DEAD:
			_process_dead_state(delta)

############################## STATE ##############################

func _enter_alive_state():
	pass


func _enter_dead_state():
	pass


func _process_alive_state(_delta:float):
	pass


func _process_dead_state(_delta:float):
	pass

############################## END ##############################



