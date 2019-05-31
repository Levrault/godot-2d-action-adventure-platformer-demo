extends Attack

export(float) var amount := 75.0

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('AttackAirHeavyGrounded')
	$DamageZone.set_amount(amount)


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'CombatIdle')