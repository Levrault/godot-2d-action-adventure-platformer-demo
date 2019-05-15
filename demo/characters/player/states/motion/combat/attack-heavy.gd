extends Motion

export(float) var amount := 50.0
onready var stream: Resource = load('res://sound/weapons/melee/sfx_wpn_punch3.wav')

func enter(host: Player) -> void:
	.enter(host)
	host.get_node('AnimationPlayer').play('AttackHeavy')
	$DamageZone.set_amount(amount)
	.play_sound(host, stream)


func exit(host: Player) -> void:
	host.has_set_next_attack = false

#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_animation_finished(anim_name: String, host: Player) -> void:
	emit_signal('finished', 'CombatIdle')