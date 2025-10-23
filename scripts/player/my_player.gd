class_name MyPlayer
extends AgentBase

@export var speed = 200
var current_state : PlayerState
@onready var state_machine : LimboHSM
@onready var weapon_manager : WeaponManager

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
	await owner.ready

func _process(delta):
	pass

func _physics_process(delta):
	pass
