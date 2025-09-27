extends AgentBase


@export var speed : float = 100
@export var behaviour_tree : BTPlayer

func _ready() -> void:
	super._ready()
	if not behaviour_tree:
		behaviour_tree = get_node("BTPlayer")
		if not behaviour_tree:
			print("could not find the behaivour tree for simple agent")
	behaviour_tree.blackboard.set_var(BBNames.speed, float(speed))
	pass
