extends Node2D


signal time_ranout # called when time ranout


# stores reference to label for time remaining
onready var time_remaining_label := $CanvasLayer/Control/TimeRemaining

# store how long it takes for the clock to count down
# export means that their values can be set in the Inspector
export(float) var duration := 60.0 # in units of seconds

var time_remaining := 0.0


# called when object first created
func _ready():
	set_time_remaining(duration)


# called every frame
func _process(delta:float):
	set_time_remaining(time_remaining - delta)


# stores and displays time remaining
func set_time_remaining(value:float):
	# store time remaining
	time_remaining = max(value, 0.0)
	
	# display time remaining
	time_remaining_label.text = str(round(value)) + " seconds remaining"
	
	# emits signal when out of time, by default clock does not know who won
	if is_equal_approx(time_remaining, 0.0):
		set_process(false) # stop counting down timer
		emit_signal("time_ranout") # signal that time has ran out

