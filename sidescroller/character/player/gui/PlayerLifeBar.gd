extends TextureRect

const SHAKE_TRIGGER = 25
const SHAKE_DISTANCE = 4
var shake_health_bar := false
var initial_margin_top := 0


func _ready() -> void:
	$TweenShakeDown.connect('tween_completed', self, '_on_tween_shake_down_completed')
	$TweenShakeUp.connect('tween_completed', self, '_on_tween_shake_up_completed')
	get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')
	initial_margin_top = margin_top


func _on_Health_changed(health_value) -> void:
	$TextureProgress.update_value(health_value)
	
	shake_health_bar = health_value <= SHAKE_TRIGGER
	
	if shake_health_bar:
		_on_tween_shake_down_completed(self, 'margin_top')


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_tween_shake_down_completed(object: Object, key: NodePath):
	if shake_health_bar:
		$TweenShakeUp.interpolate_property(self, 'margin_top', margin_top, margin_top - SHAKE_DISTANCE, 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$TweenShakeUp.start()
	else:
		_reset_margin_top()


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_tween_shake_up_completed(object: Object, key: NodePath):
	if shake_health_bar:
		$TweenShakeDown.interpolate_property(self, 'margin_top', margin_top, margin_top + SHAKE_DISTANCE, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$TweenShakeDown.start()
	else:
		_reset_margin_top()


func _reset_margin_top():
	$TweenReset.interpolate_property(self, 'margin_top', margin_top, initial_margin_top, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$TweenReset.start()