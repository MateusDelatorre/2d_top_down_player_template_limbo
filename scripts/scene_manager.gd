extends Node2D

@onready var game_holder : SubViewport
@onready var interface_holder : Node2D

func _ready() -> void:
	game_holder = %SubViewport
	interface_holder = %UIManager
