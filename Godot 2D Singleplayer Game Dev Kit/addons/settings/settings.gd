tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("DebugSettings", "res://addons/settings/DebugSettings.gd")
	
#	InputMap.add_action("debug_exit")
#	var ev = InputEventKey.new()
#	ev.scancode = KEY_ESCAPE
#	InputMap.action_add_event("debug_exit", ev)
#
#	InputMap.add_action("debug_reset")
#	ev = InputEventKey.new()
#	ev.scancode = KEY_R
#	InputMap.action_add_event("debug_reset", ev)
#
#	InputMap.add_action("debug_screenshot")
#	ev = InputEventKey.new()
#	ev.scancode = KEY_P
#	InputMap.action_add_event("debug_screenshot", ev)


func _exit_tree():
	remove_autoload_singleton("DebugSettings")
	
#	InputMap.erase_action("debug_exit")
#	InputMap.erase_action("debug_reset")
#	InputMap.erase_action("debug_screenshot")
