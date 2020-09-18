extends Attack 
class_name AirAttack


func exit(host: Player) -> void:
	.exit(host)
	if not host.has_set_next_attack:
		host.gravity_enable = true
		host.can_attack = false