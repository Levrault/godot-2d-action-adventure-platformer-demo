tool
extends TextureProgress

export(Color) var COLOR setget set_color_normal
export(float) var duration = 0.5 setget set_duration

func _ready() -> void:
	$Tween.connect('tween_completed', self, '_on_Tween_completed')
	visible = false


#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_Tween_completed(object: Object, key: NodePath) -> void:
	visible = false


func set_duration(new_duration: float) -> void:
	duration = new_duration


func start() -> void:
	visible = true
	$Tween.interpolate_property(self, 'value', 100, 0, duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func set_color_normal(value: Color) -> void:
	COLOR = value
	modulate = value