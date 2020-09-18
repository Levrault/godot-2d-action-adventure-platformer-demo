extends Node2D

signal exploded

func _ready() -> void: 
	#warning-ignore:return_value_discarded
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')


func start() -> void:
	$AnimationPlayer.play('Explode')
	$AudioStreamPlayer2D.play()


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == 'Explode')
	emit_signal('exploded')
	queue_free()
