extends OnGround

var host_cache: Character = null

func enter(host: Slime) -> void:
	host_cache = host
	host.get_node('AnimationPlayer').play('Idle')
	host.snap_enable = true
	host.velocity.x = 0
	
	
#warning-ignore:unused_argument
func update(host: Slime, delta: float) -> void:
	if host.has_target and host.can_attack:
		emit_signal('finished', 'Follow')


func exit(host: Slime) -> void:
	host.snap_enable = false