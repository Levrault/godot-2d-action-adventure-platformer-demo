extends Motion 
class_name Attack


func exit(host: Player) -> void:
	host.has_set_next_attack = false
	$DamageZone.set_monitoring(false)


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('attack') and not host.has_set_next_attack:
		host.has_set_next_attack = true
		
	return .handle_input(host, event)