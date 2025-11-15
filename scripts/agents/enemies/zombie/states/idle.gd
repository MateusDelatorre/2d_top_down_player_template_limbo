extends ZombieState


func _enter() -> void:
	if not zombie:
		zombie = agent
	zombie.animation_player.play("idle" + "_" + zombie.facing_dir)

func _exit():
	zombie.animation_player.stop()
