extends State
class_name GettingHit

onready var stream: Resource = preload('res://sound/general-sounds/simple-damage-sounds/sfx_damage_hit5.wav')


func enter(host: Character) -> void:
	host.get_node('AnimationPlayer').play('GettingHit')
	print('%s has been hit' % [host.get_name()])
	play_sound(host, stream)
	host.can_attack = false
	host.has_set_next_attack = false
	host.snap_enable = false
	host.velocity.x = host.knockback_force.x * host.look_direction.x * -1
	host.velocity.y = -host.knockback_force.y


func exit(host: Character) -> void:
	if host.is_alive:
		host.snap_enable = true
		host.can_attack = true


func _on_Animation_finished(anim_name: String, host: Character) -> void:
	assert(anim_name == 'GettingHit')
	if host.is_alive:
		emit_signal('finished', 'Previous')
	else:
		emit_signal('finished', 'Death')
