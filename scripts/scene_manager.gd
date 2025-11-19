extends Node2D
class_name SceneManager

@onready var game_holder : SubViewport
@onready var interface_holder : Node2D
@onready var debug_map_scene : PackedScene = preload("res://scenes/debug/debug_map.tscn")
@onready var debug_map : Node2D
@onready var player_scene : PackedScene = preload("res://scenes/player/player.tscn")
@onready var player : MyPlayer
@onready var player_bus : PlayerBus

func _ready() -> void:
	game_holder = %GameHolder
	interface_holder = %UIManager
	player = player_scene.instantiate()
	debug_map = debug_map_scene.instantiate()
	game_holder.add_child(debug_map)
	debug_map.add_child(player)
	if not player_bus:
		player_bus = get_children().filter(
			func(child): return child is PlayerBus
		).front()

func getPlayer() -> MyPlayer:
	return player

func getPlayerBus() -> PlayerBus:
	return player_bus
