tool
extends TextureProgress

export(Color) var COLOR setget set_color_normal

func _ready() -> void:
	get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')


func _on_Health_changed(health_value: float) -> void:
	$Tween.interpolate_property(self, 'value', value, health_value, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()


func set_color_normal(value: Color) -> void:
	COLOR = value
	modulate = value