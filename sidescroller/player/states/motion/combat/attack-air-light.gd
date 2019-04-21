extends Attack

export(float) var amount := 10.0

onready var stream: Resource = load('res://player/assets/sfx_wpn_punch1.wav')

func enter(host: Player) -> void:
	host.gravity_enable = false
	host.velocity = Vector2(0, 0)
	host.get_node('AnimationPlayer').play('AttackAirLight')
	$DamageZone.set_amount(amount)
	.play_sound(host, stream)


func exit(host: Player) -> void:
	if not host.has_set_next_attack:
		host.gravity_enable = true


#warning-ignore:unused_argument
func _on_animation_finished(anim_name: String, host: Player) -> void:
	if not host.has_set_next_attack:
		emit_signal('finished', 'Fall')
	else:
		emit_signal('finished', 'AttackAirMedium')