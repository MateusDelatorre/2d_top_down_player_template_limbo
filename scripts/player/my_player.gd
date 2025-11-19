class_name MyPlayer
extends AgentBase

@export var speed = 200
var current_state : PlayerState
@onready var state_machine : LimboHSM
@onready var weapon_manager : WeaponManager
@onready var camera : Camera2D
@onready var fov_mask : PointLight2D

func _enter_tree():
	self.add_to_group("player")
	print(self.get_groups())

func _ready() -> void:
	super._ready()
	if not animation_player:
		animation_player = get_children().filter(
			func(child): return child is AnimationPlayer
		).front()
	if not state_machine:
		state_machine = get_children().filter(
				func(child): return child is LimboHSM
			).front()
	if not weapon_manager:
		weapon_manager = get_children().filter(
			func(child): return child is WeaponManager
		).front()
	if not camera:
		camera = get_children().filter(
			func(child): return child is Camera2D
		).front()
	if not fov_mask:
		fov_mask = get_children().filter(
			func(child): return child is PointLight2D
		).front()

func _process(delta):
	pass

func scope_zoom():
	var mouse_pos : Vector2 = get_viewport().get_mouse_position()
	print(mouse_pos)
	if mouse_pos.x > mouse_pos.x/2:
		camera.position.x = mouse_pos.x/2
	else:
		camera.position.x = abs(mouse_pos.x)/2

func _physics_process(delta):
	pass
