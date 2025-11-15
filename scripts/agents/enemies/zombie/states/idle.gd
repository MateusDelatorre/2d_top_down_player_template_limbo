extends ZombieState


func _enter() -> void:
	if not zombie:
		zombie = agent
	

func _exit():
	zombie.animation_player.stop()
