extends InAir

export (float) var MAX_JUMP_FORCE:= 350.0
export (float) var MIN_JUMP_FORCE:= 200.0
export (float) var BASE_MAX_AIR_SPEED:= 75.0
export (float) var ACCELERATION:= 0.25

onready var stream: Resource = preload('res://sound/movement/jumping-and-landing/sfx_movement_jump1.wav')
var max_air_speed: float = 0


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Jump')
	play_sound(host, stream)
	host.snap_enable = false
	host.gravity_enable = true
	host.velocity.y = -MAX_JUMP_FORCE
	max_air_speed = host.velocity.x if host.velocity.x > 0 else BASE_MAX_AIR_SPEED


func handle_input(host: Player, event: InputEvent) -> InputEvent:
	if event.is_action_pressed('jump') and host.can_double_jump:
		emit_signal('finished', 'DoubleJump')

	if event.is_action_released('jump'):
		if abs(host.velocity.y) > MIN_JUMP_FORCE: 
			host.velocity.y = -MIN_JUMP_FORCE
		
	return .handle_input(host, event)


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, max_air_speed, ACCELERATION)
	if host.velocity.y > 0:
		emit_signal('finished', 'Fall')
	
