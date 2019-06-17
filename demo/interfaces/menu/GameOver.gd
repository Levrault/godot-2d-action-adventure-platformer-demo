extends Control


func show() -> void:
	visible = true
	$HBoxContainer/Retry.grab_focus()
	$HBoxContainer/Retry.connect('pressed', self, '_retry')


func _retry() -> void:
	get_tree().reload_current_scene()


func quit() -> void:
	get_tree().quit()