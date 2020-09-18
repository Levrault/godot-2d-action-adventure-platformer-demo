"""
Game over interface with some simples fade in animation.
- Retry should restart the current level
- Quit should quit the application
"""
extends Control


func _ready() -> void:
	$HBoxContainer/Retry.connect('pressed', self, '_on_Retry')
	$HBoxContainer/Quit.connect('pressed', self, '_on_Quit')


func show() -> void:
	$AnimationPlayer.play('Show')


func _on_Retry() -> void:
	LevelManager.goto_scene(LevelManager.get_scene_path())


func _on_Quit() -> void:
	get_tree().quit()