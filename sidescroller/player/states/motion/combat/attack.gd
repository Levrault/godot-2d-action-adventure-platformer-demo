extends Motion


func enter(host) -> void:
	host.get_node('AnimationPlayer').play('Attack')
	host.velocity.x = 0


func _on_animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'Attack'
	emit_signal('finished', 'CombatIdle')