extends InAir

export (float) var BASE_MAX_AIR_SPEED: float = 75.0
export (float) var ACCELERATION: float = 0.25
var max_air_speed: float = 0


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Fall')
	var current_velocity_x: float = abs(host.velocity.x)
	max_air_speed = current_velocity_x if current_velocity_x > 0 else BASE_MAX_AIR_SPEED


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, max_air_speed, ACCELERATION)

	if host.is_grounded:
		emit_signal('finished', 'Idle')
