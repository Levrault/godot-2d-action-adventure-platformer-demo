extends  GettingHit


func _on_animation_finished(anim_name: String, host: Character) -> void:
	assert anim_name == 'GettingHit'
	if host.is_alive:
		if host.is_grounded:
			emit_signal('finished', 'Idle')
		else:
			emit_signal('finished', 'Fall')
	else:
		emit_signal('finished', 'Death')