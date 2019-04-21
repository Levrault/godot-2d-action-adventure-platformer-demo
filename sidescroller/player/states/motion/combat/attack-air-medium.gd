extends Attack

export(float) var amount := 40.0

onready var stream: Resource = load('res://player/assets/sfx_wpn_punch2.wav')

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('AttackAirMedium')
	$DamageZone.set_amount(amount)
	.play_sound(host, stream)


func exit(host: Player) -> void:
	if not host.has_set_next_attack:
		host.gravity_enable = true


#warning-ignore:unused_argument
func _on_animation_finished(anim_name: String, host: Player) -> void:
	if not host.has_set_next_attack:
		emit_signal('finished', 'CombatIdle')
	else:
		emit_signal('finished', 'AttackAirHeavy')