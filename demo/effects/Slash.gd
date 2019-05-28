extends Node2D


func _ready() -> void:
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	visible = false


func _on_Animation_finished(anim_name: String) -> void:
	visible = false


func slash(type: String) -> void:
	visible = true
	$AnimationPlayer.play(type)