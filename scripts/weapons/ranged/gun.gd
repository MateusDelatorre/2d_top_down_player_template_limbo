class_name Gun
extends WeaponBase

@export var bullet : PackedScene
@export var barrel : Marker2D
var can_change_animation : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attack() -> void:
	var b = bullet.instantiate()
	get_parent().owner.get_parent().add_child(b)
	b.global_position = barrel.global_position
	b.look_at(get_global_mouse_position())
	animation_player.play()
	#b.transform = $Muzzle.transform

func change_animation(anim_name : String, facing_dir : String) -> void:
	if facing_dir == "up":
		offset = Vector2(0, -5)
		z_index = -1
	else:
		offset = Vector2(0, 5)
		z_index = 1
	if can_change_animation:
		super.change_animation(anim_name, facing_dir)

func reload() -> void:
	can_change_animation = false
	animation_player.play("reload_" + get_parent().owner.facing_direction)
	await animation_player.animation_finished
	can_change_animation = true
