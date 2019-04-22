extends Node2D


func _ready(): 
	#warning-ignore:return_value_discarded
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$AnimationPlayer.play('Explode')


func _on_Animation_finished(anim_name: String):
	assert anim_name == 'Explode'
	queue_free()