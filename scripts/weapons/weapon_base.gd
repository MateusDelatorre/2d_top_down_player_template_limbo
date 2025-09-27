class_name WeaponBase
extends Sprite2D

@export var animation_player : AnimationPlayer
@onready var agent : AgentBase
func attack() -> void:
	pass
	
func change_animation(anim_name : String, facing_dir : String) -> void:
	animation_player.play(anim_name + "_" + facing_dir)
