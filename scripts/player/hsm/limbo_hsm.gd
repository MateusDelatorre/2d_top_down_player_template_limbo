extends LimboHSM

@export var player : MyPlayer
@export var states : Dictionary[String, LimboState]

func _enter_tree():
	if not player:
		if get_parent() is MyPlayer:
			player = get_parent()

func _ready():
	_create_blackboard_names()
	await player.ready
	initialize(player)
	set_active(true)
	_binging_setup()

func _create_blackboard_names() -> void:
	blackboard.set_var(BBNames.movement_direction, Vector2.ZERO)

func _binging_setup():
	add_transition(states["idle"], states["move"], "moving")
	add_transition(states["move"], states["idle"], "stopped")
