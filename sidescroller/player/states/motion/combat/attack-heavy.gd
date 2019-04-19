extends Motion

export(float) var amount := 50.0


func enter(host: Player) -> void:
	.enter(host)
	host.get_node('AnimationPlayer').play('AttackHeavy')
	$DamageZone.set_amount(amount)


func exit(host: Player) -> void:
	host.has_set_next_attack = false


func _on_animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'CombatIdle')