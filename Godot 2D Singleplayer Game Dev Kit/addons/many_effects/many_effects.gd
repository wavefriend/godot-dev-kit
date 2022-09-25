tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("ManyParticles", "Node2D", preload("res://addons/many_effects/ManyParticles.gd"), preload("res://addons/many_effects/effect.png"))
	add_custom_type("ManySounds", "Node2D", preload("res://addons/many_effects/ManySounds.gd"), preload("res://addons/many_effects/effect.png"))


func _exit_tree():
	remove_custom_type("ManyParticles")
	remove_custom_type("ManySounds")
