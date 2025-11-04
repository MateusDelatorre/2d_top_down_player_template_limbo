class_name PlayerInput
extends Node

@export var player_action : PlayerAction
@export var limbo_hsm : LimboHSM
var blackboard : Blackboard
var input_direction : Vector2
@onready var weapon_manager : WeaponManager
@onready var player : MyPlayer

func _ready() -> void:
	if not player_action:
		player_action = PlayerAction.new()
	if not player:
		if get_parent() is MyPlayer:
			player = get_parent()
		else:
			print("PlayerInput action could not find player parent")
	player_action.create_actions()
	blackboard = limbo_hsm.blackboard
	blackboard.bind_var_to_property(BBNames.movement_direction, self, "input_direction")
	weapon_manager = get_parent().get_node("WeaponManager")
	
func _process(delta):
	input_direction = Input.get_vector(
		player_action.move_left, player_action.move_right, 
		player_action.move_up, player_action.move_down)

func _unhandled_input(event: InputEvent) -> void:
	_equipament(event)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				weapon_manager.attack_current_weapon()
	if event is InputEventMouseMotion:
		player.fov_mask.look_at(player.get_global_mouse_position())

func _equipament(event : InputEvent) -> void:
	if event.is_action_pressed(player_action.equip_1):
		weapon_manager.switch_weapon(1)
	if event.is_action_pressed(player_action.equip_2):
		weapon_manager.switch_weapon(2)
	if event.is_action_pressed(player_action.equip_3):
		weapon_manager.switch_weapon(3)
	if event.is_action_pressed(player_action.equip_4):
		weapon_manager.switch_weapon(4)
