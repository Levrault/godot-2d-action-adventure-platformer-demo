extends Motion


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('TidySword')


func _on_animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'TidySword'
	emit_signal('finished', 'Idle')