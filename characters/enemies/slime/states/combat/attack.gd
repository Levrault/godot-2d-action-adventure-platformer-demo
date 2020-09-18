extends Motion 

onready var stream: Resource = preload('res://sound/weapons/single-shot-sounds/sfx_weapon_singleshot2.wav')


func enter(host: Slime) -> void:
	host.get_node('AnimationPlayer').play('Attack')
	host.velocity = Vector2(0, 0)
	play_sound(host, stream)


#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String, host: Slime) -> void:
	host.get_node('CooldownTimer').start()
	host.can_attack = false
	if host.has_target:
		emit_signal('finished', 'Follow')
	else:
		emit_signal('finished', 'Idle')
