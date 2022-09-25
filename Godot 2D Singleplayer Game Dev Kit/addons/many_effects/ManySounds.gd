extends Node2D


onready var sounds = get_children()


# return whether sound played succesfully
func play(pos:=Vector2.ZERO, is_pos_global:=false)->bool:
	sounds.shuffle()
	
	for sound in sounds:
		if not sound.is_playing():
			if "position" in sound:
				if is_pos_global:
					sound.global_position = pos
				else:
					sound.position = pos
			
			sound.play()
			
			return true
	
	return false
