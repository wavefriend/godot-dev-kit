extends Area2D


export(float) var speed := 512.0 # pixels / sec


# called every frame
func _physics_process(delta:float):
	# moves bullet along bullet's rotation direction at speed
	global_position += speed * delta * Vector2.RIGHT.rotated(global_rotation)


# called when bullet hits something
func _on_Bullet_body_entered(body:CollisionObject2D):
	# call hit method if collider has hit method
	if is_instance_valid(body) and body.has_method("hit"):
		body.hit()
	
	# destroy bullet so that it doesnt travel forever
	queue_free()
