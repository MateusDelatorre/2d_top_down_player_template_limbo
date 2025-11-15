extends AgentBase
class_name Zombie

@export var zombie_data : ZombieData
@onready var player : MyPlayer
@onready var field_of_view : Area2D
@onready var current_behavior : Callable = func(delta): pass
@onready var zombie_hsm : LimboHSM
@onready var hitbox : Hitbox
@onready var attack_cooldown : Timer
var target : AgentBase

var speed : int
var stimulus_direction : Vector2
var can_see_player : Callable = func(): return false
var on_hearing_range : bool = false
var on_vision_range : bool = false
var behaviours : Dictionary[StringName, Callable] =\
{
	"idle": Callable(self, "idle"),
	"chase_target": Callable(self, "chase_target"),
	"chase_stimulus": Callable(self, "chase_stimulus")
}


#region initialization functions

func _ready() -> void:
	super._ready()
	init_nodes()
	load_data()
	set_state()
	attack_cooldown.timeout.connect(_on_attack_cooldown_timeout)

func init_nodes():
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
	if not zombie_hsm:
		zombie_hsm = get_children().filter(
			func(child): return child is LimboHSM
		).front()
	if not hitbox:
		hitbox = get_children().filter(
			func(child): return child is Hitbox
		).front()
	if not attack_cooldown:
		attack_cooldown = get_children().filter(
			func(child): return child is Timer
		).front()

func load_data():
	speed = zombie_data.speed
	stimulus_direction = zombie_data.stimulus_direction

func set_state():
	if stimulus_direction.is_zero_approx():
		zombie_hsm.initial_state = zombie_hsm.states["idle"]
		current_behavior = Callable(self, "idle")
	else:
		zombie_hsm.dispatch("moving")
		current_behavior = Callable(self, "chase_stimulus")
		zombie_hsm.initial_state = zombie_hsm.states["idle"]
#endregion

func _physics_process(delta):
	current_behavior.call(delta)

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
func idle(_delta):
	if on_vision_range:
		if ray_vision():
			if can_attack():
				zombie_hsm.dispatch("attack")
				current_behavior = Callable(self, "my_pass")
			else:
				zombie_hsm.dispatch("moving")
				current_behavior = Callable(self, "chase_target")

func chase_target(_delta):
	stimulus_direction = position.direction_to(player.position).normalized()
	zombie_data.stimulus_direction = stimulus_direction
	zombie_data.has_stimulus = true
	velocity = stimulus_direction * zombie_data.speed
	var box_rotation = position.angle_to_point(player.position)
	field_of_view.rotation = box_rotation
	hitbox.rotation = box_rotation
	move_and_slide()
	if not on_vision_range:
		current_behavior = Callable(self, "chase_stimulus")
	else:
		if ray_vision():
			if can_attack():
				zombie_hsm.dispatch("attack")
				current_behavior = Callable(self, "my_pass")
		else:
			current_behavior = Callable(self, "chase_stimulus")

func chase_stimulus(_delta):
	if on_vision_range:
		if ray_vision():
			if can_attack():
				zombie_hsm.dispatch("attack")
				current_behavior = Callable(self, "my_pass")
			else:
				zombie_hsm.dispatch("moving")
				current_behavior = Callable(self, "chase_target")
	if move_and_collide(stimulus_direction * speed * _delta):
		velocity = stimulus_direction * speed * _delta

func attack():
	var collsion_box : CollisionShape2D = hitbox.get_child(0)
	collsion_box.disabled = false
	zombie_hsm.dispatch("attack_cooldown")
	create_attack_cooldown()

func _on_attack_cooldown_timeout():
	var collsion_box : CollisionShape2D = hitbox.get_child(0)
	collsion_box.disabled = true
	current_behavior = Callable(self, "idle")

func hear_target() -> bool:
	return true

func die():
	pass
#endregion

#region config
func prepare_attack():
	pass

func create_attack_cooldown():
	attack_cooldown.start()
#endregion

#region checks
func ray_vision():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, player.global_position)
	var result = space_state.intersect_ray(query)
	if result["collider"] is MyPlayer:
		return true

func hit_check():
	var result = hitbox.get_overlapping_areas()
	if result is Hurtbox:
		if result.owner == self:
			return
		else:
			result.take_damage(hitbox.damage, hitbox.get_knockback(), hitbox)

func can_attack() -> bool:
	return position.distance_to(player.position) < 15

#endregion

#region area signals

func _on_detection_range_body_entered(body: Node2D) -> void:
	on_hearing_range = true

func _on_detection_range_body_exited(body: Node2D) -> void:
	on_hearing_range = false

func _on_field_of_view_body_entered(body: Node2D) -> void:
	on_vision_range = true

func _on_field_of_view_body_exited(body: Node2D) -> void:
	print("out of vision")
	on_vision_range = false

#endregion
