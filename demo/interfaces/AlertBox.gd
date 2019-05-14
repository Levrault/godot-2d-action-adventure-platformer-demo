extends Node2D
class_name AlertBox

signal interaction(type)

var host = null


func _ready() -> void:
	$Panel/Vertical/Yes.connect('pressed', self, '_on_yes_button_pressed')
	$Panel/Vertical/No.connect('pressed', self, '_on_no_button_pressed')


func start(body) -> void:
	host = body
	self.connect('interaction', host, '_change_state')
	$Panel/Vertical/Yes.grab_focus()
	$Tween.interpolate_property(self, 'modulate', Color(0, 0, 0, 0), Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func _on_yes_button_pressed() -> void:
	get_tree().quit()


func _on_no_button_pressed() -> void:
	emit_signal('interaction', 'Idle')
	queue_free()