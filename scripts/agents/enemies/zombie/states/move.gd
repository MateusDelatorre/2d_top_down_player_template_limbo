extends ZombieState

var direction_name : StringName
var equipament_name : StringName
var can_attack : bool

func _enter() -> void:
	zombie = agent
	change_animation()
	
func get_current_animation() -> StringName:
	return animation_name + "_" + agent.facing_dir

func _update(delta):
	if Vector2.ZERO.is_equal_approx(agent.velocity):
		pass
	else:
		if zombie.face_dir(zombie.velocity):
			change_animation()
