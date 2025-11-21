extends Resource
class_name PlayerBus

signal player_ready
signal player_entered_group
signal health_changed(new_health : float)
signal open_inventory
signal _signal()

func add_connection(callable: Callable) -> void:
	_signal.connect(callable)

func remove_connection(callable: Callable) -> void:
	_signal.disconnect(callable)

func emit() -> void:
	_signal.emit()
