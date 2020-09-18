extends InAir

export (float) var BASE_MAX_AIR_SPEED:= 75.0
export (float) var ACCELERATION:= 0.25
var max_air_speed: float = 0


func enter(host: Player) -> void:
	host.gravity_enable = true
	host.get_node('AnimationPlayer').play('Fall')
	var current_velocity_x: float = abs(host.velocity.x)
	max_air_speed = current_velocity_x if current_velocity_x > 0 else BASE_MAX_AIR_SPEED


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump') and host.can_double_jump:
		emit_signal('finished', 'DoubleJump')
		
	return .handle_input(host, event)


func exit(host: Player) -> void:
	if not host.can_attack:
		host.can_attack = true


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, max_air_speed, ACCELERATION)

	if host.is_grounded:
		emit_signal('finished', 'Idle')
		host.can_double_jump = true
