#*
#* agent_base.gd
#* =============================================================================
#* Copyright (c) 2023-present Serhii Snitsaruk and the LimboAI contributors.
#*
#* Use of this source code is governed by an MIT-style
#* license that can be found in the LICENSE file or at
#* https://opensource.org/licenses/MIT.
#* =============================================================================
#*
class_name AgentBase
extends CharacterBody2D
## Base agent script that is shared by all agents.

signal death

var _frames_since_facing_update: int = 0
var _is_dead: bool = false
var _moved_this_frame: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health: Health = $Health
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var facing_dir : StringName = "right"


func _ready() -> void:
	health.damaged.connect(_damaged)
	health.death.connect(die)


func _physics_process(_delta: float) -> void:
	_post_physics_process.call_deferred()


func _post_physics_process() -> void:
	if not _moved_this_frame:
		velocity = lerp(velocity, Vector2.ZERO, 0.5)
	_moved_this_frame = false


func move(p_velocity: Vector2) -> void:
	velocity = lerp(velocity, p_velocity, 0.2)
	move_and_slide()
	_moved_this_frame = true


## Update agent's facing in the velocity direction.
func update_facing() -> void:
	_frames_since_facing_update += 1
	if _frames_since_facing_update > 3:
		face_dir(velocity)

## Face specified direction.
## Returns true if facing direction was changed.
func face_dir(dir: Vector2) -> bool:
	if dir.x > 0.0:
		if not facing_dir.match("right"):
			facing_dir = "right"
			_frames_since_facing_update = 0
			return true
		return false
	elif dir.x < 0.0 :
		if not facing_dir.match("left"):
			facing_dir = "left"
			_frames_since_facing_update = 0
			return true
		return false
	if dir.y > 0.0 and not facing_dir.match("down"):
		facing_dir = "down"
		_frames_since_facing_update = 0
		return true
	if dir.y < 0.0 and not facing_dir.match("up"):
		facing_dir = "up"
		_frames_since_facing_update = 0
		return true
	return false

## Returns 1.0 when agent is facing right.
## Returns -1.0 when agent is facing left.
func get_facing() -> float:
	if facing_dir.match("right"):
		return 1.0
	else:
		return -1.0

## Is specified position inside the arena (not inside an obstacle)?
func is_good_position(p_position: Vector2) -> bool:
	var space_state := get_world_2d().direct_space_state
	var params := PhysicsPointQueryParameters2D.new()
	params.position = p_position
	params.collision_mask = 1 # Obstacle layer has value 1
	var collision := space_state.intersect_point(params)
	return collision.is_empty()


## When agent is damaged...
func _damaged(_amount: float, knockback: Vector2) -> void:
	return
	apply_knockback(knockback)
	animation_player.play(&"hurt")
	var btplayer := get_node_or_null(^"BTPlayer") as BTPlayer
	if btplayer:
		btplayer.set_active(false)
	var hsm := get_node_or_null(^"LimboHSM")
	if hsm:
		hsm.set_active(false)
	await animation_player.animation_finished
	if btplayer and not _is_dead:
		btplayer.restart()
	if hsm and not _is_dead:
		hsm.set_active(true)


## Push agent in the knockback direction for the specified number of physics frames.
func apply_knockback(knockback: Vector2, frames: int = 10) -> void:
	if knockback.is_zero_approx():
		return
	for i in range(frames):
		move(knockback)
		await get_tree().physics_frame


func die() -> void:
	if _is_dead:
		return
	death.emit()
	_is_dead = true
	process_mode = Node.PROCESS_MODE_DISABLED
	collision_shape_2d.set_deferred(&"disabled", true)

	for child in get_children():
		if child is BTPlayer or child is LimboHSM:
			child.set_active(false)
	animation_player.play("death"+"_"+facing_dir)
	if get_tree():
		await get_tree().create_timer(10.0).timeout
		queue_free()


func get_health() -> Health:
	return health
