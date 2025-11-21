extends Control

@export var player_bus : PlayerBus

func _ready():
	player_bus.open_inventory.connect(_open_inventory)

func _open_inventory():
	visible = true
