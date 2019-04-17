extends OnGround

# pixels/sec
export (float) var WALK_SPEED: float = 125
export (float) var ACCELERATION: float = 1


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Move')
	host.snap_enable = true


func exit(host) -> void:
	host.snap_enable = false


#warning-ignore:unused_argument
func update(host, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	update_look_direction(host, get_input_direction())
	if not input_direction:
		emit_signal('finished', 'Idle')
	
	move(host, input_direction, WALK_SPEED, ACCELERATION)
