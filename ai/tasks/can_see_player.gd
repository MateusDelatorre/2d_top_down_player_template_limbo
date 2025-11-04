@tool
extends BTCondition
## InRange condition checks if the agent is within a range of target,
## defined by [member distance_min] and [member distance_max]. [br]
## Returns [code]SUCCESS[/code] if the agent is within the given range;
## otherwise, returns [code]FAILURE[/code].

## Blackboard variable that holds the target (expecting Node2D).
@export var target_var: StringName = &"target"

## Blackboard variable that holds the target (expecting Node2D).
@export var vision_var: StringName = &"vision_range"

var target : Node2D
var vision_range : int


# Called to generate a display name for the task.
func _generate_name() -> String:
	return "Can see %s" % [LimboUtility.decorate_var(target_var)]


# Called to initialize the task.
func _setup() -> void:
	pass

# Called each time this task is entered.
func _enter() -> void:
	target = blackboard.get_var(target_var, null)
	vision_range = blackboard.get_var(vision_var, 0)
	if not is_instance_valid(target):
		print("instance not valid")

# Called when the task is executed.
func _tick(_delta: float) -> Status:
	if not is_instance_valid(target):
		return FAILURE

	var dist_sq: float = agent.global_position.distance_to(target.global_position)
	
	if dist_sq <= vision_range:
		return SUCCESS
	else:
		return FAILURE
