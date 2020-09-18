extends InAir

export (float) var JUMP_FORCE:= 250.0
export (float) var BASE_MAX_AIR_SPEED:= 75.0
export (float) var ACCELERATION:= 0.25

onready var stream: Resource = preload('res://sound/movement/jumping-and-landing/sfx_movement_jump1.wav')
var max_air_speed: float = 0


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('DoubleJump')
	play_sound(host, stream)
	host.snap_enable = false
	host.can_double_jump = false
	host.velocity.y = -JUMP_FORCE
	max_air_speed = host.velocity.x if host.velocity.x > 0 else BASE_MAX_AIR_SPEED


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, input_direction)

	move(host, input_direction, max_air_speed, ACCELERATION)


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'Fall')