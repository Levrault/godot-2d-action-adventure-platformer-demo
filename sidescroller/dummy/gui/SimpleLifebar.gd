tool
extends TextureProgress

export(Color) var COLOR setget set_color_normal


func _ready():
	get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')
	$Tween.connect('tween_completed', self, '_on_tween_color_completed')

func _on_Health_changed(health_value):
	$Tween.interpolate_property(self, 'value', value, health_value, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()


func set_color_normal(value):
	COLOR = value
	modulate = value