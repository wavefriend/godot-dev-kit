extends Node2D

############################## SIGNALS ##############################

signal screen_change_requested(screen_name, data)

############################## INIT ##############################

# called when added to tree
func init(_data:={}):
	pass

############################## METHODS ##############################

func request_screen_change(screen_name:String, data:={}):
	emit_signal("screen_change_requested", screen_name, data)

############################## END ##############################


