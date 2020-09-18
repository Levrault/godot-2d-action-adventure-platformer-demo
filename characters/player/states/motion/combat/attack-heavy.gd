extends Attack

export(float) var amount := 50.0
onready var stream: Resource = preload('res://sound/weapons/melee/sfx_wpn_punch3.wav')


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('AttackHeavy')
	$DamageZone.set_type_of_attack('Heavy')
	$DamageZone.set_amount(amount)
	.play_sound(host, stream)


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'CombatIdle')
