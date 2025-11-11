extends LimboHSM
class_name ZombieSM

@export var zombie : AgentBase
@export var states : Dictionary[String, LimboState]

func _enter_tree():
	if not zombie:
		if not search_tree(self):
			print("could not find zombie parent")

func _ready():
	_create_blackboard_names()
	await zombie.ready
	initialize(zombie)
	set_active(true)
	_binging_setup()

func _create_blackboard_names() -> void:
	blackboard.set_var(BBNames.movement_direction, Vector2.ZERO)

func _binging_setup():
	add_transition(states["idle"], states["move"], "moving")
	add_transition(states["move"], states["idle"], "stopped")
	add_transition(ANYSTATE, states["attack"], "attack", Callable(zombie, "is_alive"))
	add_transition(ANYSTATE, states["die"], "died", Callable(zombie, "is_alive"))
	

func search_tree(parent) -> bool:
	if parent.get_parent() is AgentBase:
			zombie = get_parent()
			return true
	else:
		search_tree(parent.get_parent())
	return false
