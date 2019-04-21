extends Motion
class_name InAir


func handle_input(host: Player, event: InputEvent):
	if event.is_action_pressed('attack') and host.can_attack:
		emit_signal('finished', 'AttackAirLight')
	return .handle_input(host, event)