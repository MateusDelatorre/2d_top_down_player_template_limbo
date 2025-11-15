extends ZombieState

func _ready():
	if not zombie:
		zombie = get_parent().get_parent()
	zombie.ready.connect(_zombie_ready)

func _zombie_ready():
	zombie.animation_player.animation_finished.connect\
	(_on_animation_player_animation_finished)

func _enter() -> void:
	zombie = agent
	change_animation()

func _update(delta):
	pass

func _on_animation_player_animation_finished(anim_name : StringName):
	if anim_name.contains("death"):
		zombie.remove()
