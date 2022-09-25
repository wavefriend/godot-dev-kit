extends Node2D


onready var particles := get_children()


# returns whether particles were emitted succesfully
func emit(pos:Vector2, is_pos_global:=false)->bool:
	for particle in particles:
		if not particle.emitting:
			if is_pos_global:
				particle.global_position = pos
			else:
				particle.position = pos
			
			particle.emitting = true
			
			return true
	
	return false
