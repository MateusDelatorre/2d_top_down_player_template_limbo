extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var root: Node2D = $Root


func _on_health_damaged(_amount: float, _knockback: Vector2) -> void:
	print("got shot")


func get_facing() -> float:
	return signf(root.scale.x)
