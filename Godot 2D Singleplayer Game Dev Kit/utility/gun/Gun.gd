extends Node2D


const BULLET_SCENE := preload("res://utility/bullet/Bullet.tscn")


onready var fire_point := $FirePoint


func _physics_process(_delta:float):
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot():
	var inst := BULLET_SCENE.instance()
	
	var game = get_parent().get_parent()
	
	game.add_child(inst)
	inst.global_position = fire_point.global_position
	inst.global_rotation = global_rotation
	
	pass
