extends State

const EXPLOSION_SCENE: Resource = preload('res://sfx/Explosion.tscn')


func enter(host: Player) -> void:
	host.get_node('AnimationPlayer').play('Death')
	host.snap_enable = true
	host.velocity = Vector2(0, 0)


func _on_animation_finished(anim_name: String, host: Player) -> void:
	assert anim_name == 'Death'
	var explosion := EXPLOSION_SCENE.instance()
	explosion.set_position(host.get_global_position())
	get_tree().get_root().add_child(explosion)
	host.queue_free()