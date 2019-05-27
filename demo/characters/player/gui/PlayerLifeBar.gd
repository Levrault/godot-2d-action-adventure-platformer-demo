extends TextureRect

const LOW_HEALTH_TRIGGER = 25
var is_health_low: bool = false


func _ready() -> void:
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	if get_parent().get_parent().has_node('Health'):
		get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')


func _on_Health_changed(health_value: float) -> void:
	$TextureProgress.update_value(health_value)
	is_health_low = health_value <= LOW_HEALTH_TRIGGER
	$AnimationPlayer.play('Shake')
	

func _on_Animation_finished(anim_name: String) -> void:
	match anim_name:
		'Shake':
			if is_health_low:
				$AnimationPlayer.play('Flash')
		'Flash':
			if not is_health_low:
				$AnimationPlayer.stop('Flash')
	
