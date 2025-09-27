class_name Bullet
extends Hitbox

var speed = 1000
var parent : Sprite2D

func _enter_tree() -> void:
	parent = get_parent()

func _ready() -> void:
	super()
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("area_entered", Callable(self, "_area_entered"))
			
func _area_entered(hurtbox: Hurtbox) -> void:
	super(hurtbox)
	parent.queue_free()

func _physics_process(delta):
	parent.position += parent.transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	parent.queue_free()
