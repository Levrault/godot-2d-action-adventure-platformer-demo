extends OnGround


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('CombatIdle')
	host.velocity.x = 0
	host.can_attack = false
	host.start_cooldown()
	$CombatIdleTimer.start()
  

#warning-ignore:unused_argument
func exit(host: Player) -> void:
	$CombatIdleTimer.stop()


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func update(host: Player, delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x:
		emit_signal('finished', 'Move')


func _on_CombatIdleTimer_timeout():
	$CombatIdleTimer.stop()
	emit_signal('finished', 'TidySword')
