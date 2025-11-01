extends AgentBase

@export var behaviour_tree : BTPlayer
@export var zombie_data : ZombieData
@onready var navigation_agent : NavigationAgent2D
@onready var player : MyPlayer


var last_stimulus : Vector2

func _ready() -> void:
	super._ready()
	if not behaviour_tree:
		behaviour_tree = get_node("BTPlayer")
		if not behaviour_tree:
			print("could not find the behaivour tree for simple agent")
	if not player:
		player = get_tree().get_first_node_in_group("player")
	set_blackboard_variables()
	pass

func set_blackboard_variables():
	behaviour_tree.blackboard.set_var(BBNames.speed, float(zombie_data.speed))
	behaviour_tree.blackboard.set_var(BBNames.vision_range, int(zombie_data.vision_range))
	behaviour_tree.blackboard.set_var(BBNames.hearing_range, int(zombie_data.hearing_range))
	behaviour_tree.blackboard.set_var(BBNames.last_stimulus, Vector2.ZERO)
	behaviour_tree.blackboard.set_var(BBNames.player, null)
