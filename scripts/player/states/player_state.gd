class_name PlayerState
extends LimboState

@export var animation_name : StringName
var direction_name : StringName
var equipament_name : StringName
static var player : Player

func _enter_tree() -> void:
	if owner is Player:
		player = owner

func _ready() -> void:
	await player.ready
	await player.weapon_manager.ready

func _enter() -> void:
	player.animation_player.play(animation_name + "_" + player.facing_dir)
	player.weapon_manager.current_weapon.animation_player.play(animation_name + "_" + player.facing_dir)
	
func move() -> Vector2:
	var direction : Vector2 = blackboard.get_var(BBNames.direction)
	
	if not Vector2.ZERO.is_equal_approx(direction):
		if player.face_dir(direction):
			change_animation()
	
	var desired_velocity : Vector2 = direction * player.speed
	player.move(desired_velocity)
	return desired_velocity

func change_animation() -> void:
	player.animation_player.play(animation_name + "_" + player.facing_dir)
	player.weapon_manager.change_animation(animation_name, player.facing_dir)
	
func get_current_animation() -> StringName:
	return animation_name + "_" + player.facing_dir
