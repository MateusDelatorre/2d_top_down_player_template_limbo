extends LimboState
class_name ZombieState

@onready var zombie : Zombie
@export var animation_name : StringName

func _ready():
	if not agent:
		await owner.ready
		zombie = agent

func _enter() -> void:
	zombie.animation_player.play(animation_name + "_" + zombie.facing_dir)

func change_animation() -> void:
	zombie.animation_player.play(animation_name + "_" + zombie.facing_dir)
	
func get_current_animation() -> StringName:
	return animation_name + "_" + zombie.facing_dir
