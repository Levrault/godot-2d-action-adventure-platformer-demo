extends Motion
class_name OnGround


func handle_input(host, event):
	if event.is_action_pressed('jump'):
		emit_signal('finished', 'Jump')
	elif event.is_action_pressed('run'):
		emit_signal('finished', 'Run')
	elif event.is_action_pressed('backdash') and not host.cooldown_states['BackDash']:
		emit_signal('finished', 'BackDash')
	elif event.is_action_pressed('dodgeroll') and not host.cooldown_states['DodgeRoll']:
		emit_signal('finished', 'DodgeRoll')
	elif event.is_action_pressed('attack') and not host.cooldown_states[host.primary_weapon]:
		emit_signal('finished', host.primary_weapon)
	elif event.is_action_pressed('secondary_attack') and not host.cooldown_states[host.secondary_weapon]:
		emit_signal('finished', host.secondary_weapon)

	if host.ladder_climb_enable:
		if event.is_action_pressed('move_up') and host.ladder_is_entering_bottom:
			emit_signal('finished', 'LadderBottomIntro')
		elif event.is_action_pressed('move_down') and host.ladder_is_entering_top:
			emit_signal('finished', 'LadderTopIntro')

	if event.is_action_pressed('move_down') and not host.ladder_is_entering_top:
		emit_signal('finished', 'GettingDown')

	return .handle_input(host, event)
