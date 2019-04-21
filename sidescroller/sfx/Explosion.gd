extends Node2D


func _ready():
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')


func _on_Animation_finished():
	queue_free()