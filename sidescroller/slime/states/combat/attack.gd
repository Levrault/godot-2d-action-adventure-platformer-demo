extends Motion 

func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Attack')
	host.velocity = Vector2(0, 0)


func _on_animation_finished(anim_name: String, host: Slime) -> void:
	host.get_node('CooldownTimer').start()
	host.can_attack = false
	if host.has_target:
		emit_signal('finished', 'Follow')
	else:
		emit_signal('finished', 'Idle')
