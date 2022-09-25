extends Node

############################## CONSTANTS ##############################

const EFFECT_DURATIONS := {
	"FIRE":1.0,
	"SLOW":1.0
}

############################## VARIABLES ##############################

var effects := {
	"fire":-1.0,
	"slow":-1.0
}

############################## INIT ##############################

func _ready():
	pass

############################## PROCESS ##############################

func _process(delta:float):
	if is_on_fire():
		_process_fire_effect(delta)
	if is_slow():
		_process_slow_effect(delta)

############################## EFFECT ##############################

func is_on_fire()->bool:
	return effects.fire > 0.0


func start_fire_effect():
	effects.fire = EFFECT_DURATIONS.FIRE


func finish_fire_effect():
	effects.fire = -1.0


func _process_fire_effect(delta:float):
	effects.fire -= delta
	
	if effects.fire <= 0.0:
		finish_fire_effect()


func is_slow()->bool:
	return effects.slow > 0.0


func start_slow_effect():
	effects.slow = EFFECT_DURATIONS.SLOW


func finish_slow_effect():
	effects.slow = -1.0


func _process_slow_effect(delta:float):
	effects.slow -= delta
	
	if effects.slow <= 0.0:
		finish_slow_effect()

############################## END ##############################

