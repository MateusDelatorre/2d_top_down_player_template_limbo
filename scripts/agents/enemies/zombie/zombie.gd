extends AgentBase

@export var behaviour_tree : BTPlayer
@export var zombie_data : ZombieData
@onready var navigation_agent : NavigationAgent2D
@onready var player : MyPlayer


var last_stimulus : Vector2

func _ready() -> void:
	super._ready()
	init_nodes()
	set_blackboard_variables()
	pass
	pass

func init_nodes():
	if not behaviour_tree:
		behaviour_tree = get_node("BTPlayer")
		if not behaviour_tree:
			print("could not find the behaivour tree for simple agent")
	if not player:
		player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	pass

func _process(delta: float) -> void:
	pass


func set_blackboard_variables():
	behaviour_tree.blackboard.set_var(BBNames.movement_speed, float(zombie_data.speed))
	behaviour_tree.blackboard.set_var(BBNames.vision_range, int(zombie_data.vision_range))
	behaviour_tree.blackboard.set_var(BBNames.hearing_range, int(zombie_data.hearing_range))
	behaviour_tree.blackboard.set_var(BBNames.last_stimulus, zombie_data.last_stimulus)
	behaviour_tree.blackboard.set_var(BBNames.stimulus_direction, zombie_data.stimulus_direction)
	behaviour_tree.blackboard.set_var(BBNames.player, player)

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_detection_range_body_entered(body: Node2D) -> void:
	print("change")
