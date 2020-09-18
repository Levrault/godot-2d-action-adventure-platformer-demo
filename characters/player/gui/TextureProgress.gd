tool
extends TextureProgress

export(Color) var COLOR setget set_color_normal

func _ready() -> void:
	$TweenColor.connect('tween_completed', self, '_on_tween_color_completed')


func update_value(new_value: float) -> void:
	$TweenColor.interpolate_property(self, 'modulate', modulate, Color(255, 255, 255), 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	$TweenColor.start()
	
	$TweenProgress.interpolate_property(self, 'value', value, new_value, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$TweenProgress.start()


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_tween_color_completed(object: Object, key: NodePath) -> void:
	set_color_normal(COLOR)
	
	
func set_color_normal(value: Color) -> void:
	COLOR = value
	modulate = value
