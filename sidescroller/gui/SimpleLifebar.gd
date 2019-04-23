extends TextureProgress


func _ready():
	#warning-ignore:return_value_discarded
	get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')


func _on_Health_changed(health_value):
	$Tween.interpolate_property(self, 'value', value, health_value, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()