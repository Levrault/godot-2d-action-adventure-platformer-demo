extends AirAttack

export(float) var amount := 50.0
onready var stream: Resource = preload('res://sound/weapons/melee/sfx_wpn_punch3.wav')

func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('AttackAirHeavy')
	host.gravity_enable = true
	host.velocity.y = 900
	$DamageZone.set_amount(amount)
	.play_sound(host, stream)


func exit(host: Player) -> void:
	host.has_set_next_attack = false
	$DamageZone.set_monitoring(false)


#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	if host.is_grounded:
		emit_signal('finished', 'AttackAirHeavyGrounded')