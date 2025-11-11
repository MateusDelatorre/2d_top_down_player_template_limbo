extends ZombieState

@export var animation_name : StringName
var direction_name : StringName
var equipament_name : StringName

func _enter() -> void:
	agent.animation_player.play("move" + "_" + agent.facing_dir)
	

func change_animation() -> void:
	agent.animation_player.play("move" + "_" + agent.facing_dir)
	
func get_current_animation() -> StringName:
	return animation_name + "_" + agent.facing_dir

func _update(delta):
	if Vector2.ZERO.is_equal_approx(agent.velocity):
		dispatch("stopped", agent.velocity)
	else:
		if agent.face_dir(agent.velocity):
			change_animation()
