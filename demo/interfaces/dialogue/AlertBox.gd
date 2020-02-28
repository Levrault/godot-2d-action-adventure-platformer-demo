extends Node2D
class_name AlertBox

signal interaction(type)

export(String) var scene_path = '' setget set_scene_path

var host = null


func _ready() -> void:
	$Panel/Vertical/Yes.connect('pressed', self, '_on_Yes_button_pressed')
	$Panel/Vertical/No.connect('pressed', self, '_on_No_button_pressed')


func start(body) -> void:
	host = body
	self.connect('interaction', host, '_change_state')
	$Panel/Vertical/Yes.grab_focus()
	$Tween.interpolate_property(self, 'modulate', Color(0, 0, 0, 0), Color(1, 1, 1, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()


func set_scene_path(new_scene_path: String) -> void:
	scene_path = new_scene_path


func _on_Yes_button_pressed() -> void:
	LevelManager.goto_scene('res://%s.tscn' % [scene_path])


func _on_No_button_pressed() -> void:
	emit_signal('interaction', 'Idle')
	queue_free()
