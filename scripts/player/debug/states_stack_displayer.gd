extends Panel
## Shows the current state of the state machine as a text

@export var limbo_hsm : LimboHSM :
	set(value):
		if limbo_hsm!=null:
			limbo_hsm.active_state_changed.\
			disconnect(_on_active_state_change)
		limbo_hsm = value
		
		if limbo_hsm!=null:
			# Initial text set
			var current_state = \
			limbo_hsm.get_active_state()
			
			if current_state != null:
				%States.text = current_state.name
			
			limbo_hsm.active_state_changed.\
			connect(_on_active_state_change)

func _on_active_state_change(current : LimboState, \
_previous : LimboState):
	%States.text = current.name
	
