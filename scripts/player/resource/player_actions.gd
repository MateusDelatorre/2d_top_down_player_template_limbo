class_name PlayerAction
extends Resource

@export var move_down: String = "move_down"
@export var move_left: String = "move_left"
@export var move_right: String = "move_right"
@export var move_up: String = "move_up"
@export var attack: String = "attack"
@export var run: String = "run"
@export var equip_1: String = "equip_1"
@export var equip_2: String = "equip_2"
@export var equip_3: String = "equip_3"
@export var equip_4: String = "equip_4"
@export var pause: String = "pause"

func create_actions():
	_create_move_down_event()
	_create_move_left_event()
	_create_move_right_event()
	_create_move_up_event()
	_create_attack_event()
	_create_run_event()
	_create_quick_slot1_event()
	_create_quick_slot2_event()
	_create_quick_slot3_event()
	_create_quick_slot4_event()
	_create_pause_event()
	
func _create_move_down_event():
	if not InputMap.has_action(move_down):
		InputMap.add_action(move_down)
		var event = InputEventKey.new()
		event.keycode = KEY_S
		InputMap.action_add_event(move_down, event)

func _create_move_left_event():
	if not InputMap.has_action(move_left):
		InputMap.add_action(move_left)
		var event = InputEventKey.new()
		event.keycode = KEY_A
		InputMap.action_add_event(move_left, event)

func _create_move_right_event():
	if not InputMap.has_action(move_right):
		InputMap.add_action(move_right)
		var event = InputEventKey.new()
		event.keycode = KEY_D
		InputMap.action_add_event(move_right, event)

func _create_move_up_event():
	if not InputMap.has_action(move_up):
		InputMap.add_action(move_up)
		var event = InputEventKey.new()
		event.keycode = KEY_W
		InputMap.action_add_event(move_up, event)

func _create_attack_event():
	if not InputMap.has_action(attack):
		InputMap.add_action(attack)
		var event = InputEventMouseButton.new()
		event.button_index = MOUSE_BUTTON_LEFT
		InputMap.action_add_event(attack, event)

func _create_run_event():
	if not InputMap.has_action(run):
		InputMap.add_action(run)
		var event = InputEventKey.new()
		event.keycode = KEY_SHIFT
		InputMap.action_add_event(run, event)

func _create_quick_slot1_event():
	if not InputMap.has_action(equip_1):
		InputMap.add_action(equip_1)
		var event = InputEventKey.new()
		event.keycode = KEY_1
		InputMap.action_add_event(equip_1, event)

func _create_quick_slot2_event():
	if not InputMap.has_action(equip_2):
		InputMap.add_action(equip_2)
		var event = InputEventKey.new()
		event.keycode = KEY_2
		InputMap.action_add_event(equip_2, event)

func _create_quick_slot3_event():
	if not InputMap.has_action(equip_3):
		InputMap.add_action(equip_3)
		var event = InputEventKey.new()
		event.keycode = KEY_3
		InputMap.action_add_event(equip_3, event)

func _create_quick_slot4_event():
	if not InputMap.has_action(equip_4):
		InputMap.add_action(equip_4)
		var event = InputEventKey.new()
		event.keycode = KEY_4
		InputMap.action_add_event(equip_4, event)

func _create_pause_event():
	if not InputMap.has_action(pause):
		InputMap.add_action(pause)
		var event = InputEventKey.new()
		event.keycode = KEY_ESCAPE
		InputMap.action_add_event(pause, event)
		event.keycode = KEY_P
		InputMap.action_add_event(pause, event)