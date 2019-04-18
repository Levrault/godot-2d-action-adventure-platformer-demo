extends OnGround

# pixels/sec
export (float) var WALK_SPEED:= 125
export (float) var ACCELERATION:= 1


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Move')
	host.snap_enable = true


func exit(host) -> void:
	host.snap_enable = false


#warning-ignore:unused_argument
func update(host, delta: float) -> void:
	if not host.velocity:
		emit_signal('finished', 'Idle')
	
	move(host, host.velocity, WALK_SPEED, ACCELERATION)
