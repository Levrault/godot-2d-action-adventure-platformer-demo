extends Control


func _ready():
	$HBoxContainer/Retry.grab_focus()
	$HBoxContainer/Retry.connect('pressed', self, '_retry')


func _retry():
	get_tree().change_scene('res://Game.tscn')


func quit():
	get_tree().quit()