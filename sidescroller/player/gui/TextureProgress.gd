extends TextureProgress


func update_value(new_value):
	$Tween.interpolate_property(self, 'value', value, new_value, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()