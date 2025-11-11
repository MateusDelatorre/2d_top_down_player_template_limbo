extends AgentBase

@export var behaviour_tree : BTPlayer
@export var zombie_data : ZombieData
@onready var player : MyPlayer
@onready var field_of_view : Area2D
@onready var current_behavior : Callable = func(delta): pass

var speed : int
var stimulus_direction : Vector2
var can_see_player : Callable = func(): return false
var _on_hearing_range : bool = false
var _on_vision_range : bool = false

#region initialization functions

func _ready() -> void:
	super._ready()
	init_nodes()
	load_data()
	current_behavior = Callable(self, "idle")
	pass

func init_nodes():
	if not behaviour_tree:
		behaviour_tree = get_node("BTPlayer")
		if not behaviour_tree:
			print("could not find the behaivour tree for simple agent")
	if not player:
		player = get_tree().get_first_node_in_group("player")
	if not field_of_view:
		field_of_view = get_children().filter(
			func(child : Node): return child is Area2D and child.name.begins_with("F")
		).front()
		if not field_of_view:
			print("could not find FieldOfView")
	if not animation_player:
		animation_player = get_children().filter(
			func(child): return child is AnimationPlayer
		).front()

func load_data():
	speed = zombie_data.speed
	stimulus_direction = zombie_data.stimulus_direction
	print(stimulus_direction)

#endregion

func _physics_process(delta):
	#current_behavior.call(delta)
	tree(delta)

func _process(delta: float) -> void:
	pass

func set_blackboard_variables():
	pass
	#behaviour_tree.blackboard.set_var(BBNames.movement_speed, float(zombie_data.speed))
	#behaviour_tree.blackboard.set_var(BBNames.vision_range, int(zombie_data.vision_range))
	#behaviour_tree.blackboard.set_var(BBNames.hearing_range, int(zombie_data.hearing_range))
	#behaviour_tree.blackboard.set_var(BBNames.last_stimulus, zombie_data.last_stimulus)
	#behaviour_tree.blackboard.set_var(BBNames.stimulus_direction, zombie_data.stimulus_direction)
	#behaviour_tree.blackboard.set_var(BBNames.player, player)

#region behaviour
func tree(_delta):
	if _on_vision_range:
		if ray_vision():
			chase_target(_delta)
	else:
		if zombie_data.has_stimulus:
			chase_stimulus(_delta)
		else:
			idle(_delta)

func chase_target(_delta):
	stimulus_direction = position.direction_to(player.position).normalized()
	zombie_data.has_stimulus = true
	velocity = position.direction_to(player.position).normalized() * zombie_data.speed
	field_of_view.rotation = position.angle_to_point(player.position)
	move_and_slide()

func chase_stimulus(_delta):
	
	if move_and_collide(stimulus_direction * speed * _delta):
		velocity = stimulus_direction * speed * _delta
	

func hear_target() -> bool:
	return true

func idle(_delta):
	pass

func die():
	pass
#endregion

#region checks
func ray_vision():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	var result = space_state.intersect_ray(query)
	if result["collider"] is MyPlayer:
		return true
	
#endregion

#region area signals

func _on_detection_range_body_entered(body: Node2D) -> void:
	_on_hearing_range = true

func _on_detection_range_body_exited(body: Node2D) -> void:
	_on_hearing_range = false

func _on_field_of_view_body_entered(body: Node2D) -> void:
	_on_vision_range = true

func _on_field_of_view_body_exited(body: Node2D) -> void:
	_on_vision_range = false

#endregion
