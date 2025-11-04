@tool
extends BTAction
## Move towards the direction. [br]
## Returns [code]RUNNING[/code] while moving towards the target but not yet at the desired position. [br]
## Returns [code]SUCCESS[/code] when at the desired position relative to the target (flanking it). [br]
## Returns [code]FAILURE[/code] if the target is not a valid [Node2D] instance. [br]

## Blackboard variable that stores our target (expecting Vector2).
@export var direction_var: StringName = &"direction"

## Blackboard variable that stores desired speed.
@export var speed_var: StringName = &"speed"

## Desired distance from target.
@export var approach_distance: int = 10.0

var _waypoint: Vector2


# Display a customized name (requires @tool).
func _generate_name() -> String:
	return "Go to %s" % [LimboUtility.decorate_var(direction_var)]

# Called each time this task is entered.
func _enter() -> void:
	var direction: Vector2 = blackboard.get_var(direction_var, null)

# Called each time this task is ticked (aka executed).
func _tick(_delta: float) -> Status:
	var direction : Vector2 = blackboard.get_var(direction_var, null)
	
	if Vector2.ZERO.is_equal_approx(direction):
		return FAILURE
	return FAILURE


## Get the closest flanking position to target.
func _get_desired_position(target: Node2D) -> Vector2:
	var side: float = signf(agent.global_position.x - target.global_position.x)
	var desired_pos: Vector2 = target.global_position
	desired_pos.x += approach_distance * side
	return desired_pos


## Select an intermidiate waypoint towards the desired position.
func _select_new_waypoint(desired_position: Vector2) -> void:
	var distance_vector: Vector2 = desired_position - agent.global_position
	var angle_variation: float = randf_range(-0.2, 0.2)
	_waypoint = agent.global_position + distance_vector.limit_length(150.0).rotated(angle_variation)
