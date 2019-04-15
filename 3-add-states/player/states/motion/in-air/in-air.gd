extends Motion
class_name InAir


func handle_input(host: Character, event: InputEvent):
	if host.ladder_climb_enable:
		if event.is_action_pressed('move_up'):
			host.ladder_is_climb_position_needed = true
			emit_signal('finished', 'LadderClimb')

	return .handle_input(host, event)