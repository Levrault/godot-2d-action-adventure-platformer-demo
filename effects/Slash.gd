extends Node2D


func _ready() -> void:
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	visible = false


#warning-ignore:unused_argument
func _on_Animation_finished(anim_name: String) -> void:
	visible = false


func slash(type: String) -> void:
	visible = true
	$AnimationPlayer.play(type)