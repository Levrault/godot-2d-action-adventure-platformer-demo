extends Motion
class_name OnGround


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump'):
		emit_signal('finished', 'Jump')

	return .handle_input(host, event)
