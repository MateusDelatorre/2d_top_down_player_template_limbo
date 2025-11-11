extends ZombieState

func _enter() -> void:
	agent.animation_player.play("move" + "_" + agent.facing_dir)
