extends Motion
class_name OnGround


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump'):
		emit_signal('finished', 'Jump')
	elif event.is_action_pressed('attack') and host.can_attack:
		emit_signal('finished', 'AttackLight')

	return .handle_input(host, event)
