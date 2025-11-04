extends SubViewportContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_viewport().connect("size_changed", _root_viewport_size_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when the root's viewport size changes (i.e. when the window is resized).
# This is done to handle multiple resolutions without losing quality.
func _root_viewport_size_changed():
	# The viewport is resized depending on the window height.
	# To compensate for the larger resolution, the viewport sprite is scaled down.
	#size = Vector2.ONE * get_viewport().size.y
	pass
	
