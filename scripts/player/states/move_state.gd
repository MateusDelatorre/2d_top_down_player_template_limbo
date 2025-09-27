extends PlayerState

func _update(delta):
	var velocity : Vector2 = move()
	if Vector2.ZERO.is_equal_approx(velocity):
		dispatch("stopped", velocity)
