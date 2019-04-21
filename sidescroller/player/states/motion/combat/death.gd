extends State

const EXPLOSION_SCENE: Resource = preload('res://sfx/Explosion.tscn')


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Death')
	host.snap_enable = true
	host.velocity = Vector2(0, 0)


func _on_animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'Death'
	host.queue_free()