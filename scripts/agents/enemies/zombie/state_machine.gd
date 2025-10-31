extends LimboHSM
class_name ZombieSM

@export var zombie : AgentBase
@export var states : Dictionary[String, LimboState]

func _enter_tree():
	if not zombie:
		if get_parent() is AgentBase:
			zombie = get_parent()

func _ready():
	await zombie.ready
	initialize(zombie)
	set_active(true)
