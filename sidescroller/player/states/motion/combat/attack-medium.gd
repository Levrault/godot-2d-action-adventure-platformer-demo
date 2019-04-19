extends Attack

export(float) var amount := 40.0


func enter(host: Player) -> void:
	.enter(host)
	host.get_node('AnimationPlayer').play('AttackMedium')
	$DamageZone.set_amount(amount)


func _on_animation_finished(anim_name: String, host: Player) -> void:
	if host.is_combo_over:
		emit_signal('finished', 'CombatIdle')
	else:
		emit_signal('finished', 'AttackHeavy')