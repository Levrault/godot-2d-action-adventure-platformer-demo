extends State


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Idle')
	host.snap_enable = true
	host.velocity.x = 0