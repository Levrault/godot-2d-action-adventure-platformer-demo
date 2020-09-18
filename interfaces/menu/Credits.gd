extends Control

func _ready():
	$Button.connect('pressed', self, '_on_Pressed')
	

func _on_Pressed():
	get_tree().change_scene('res://interfaces/menu/MainMenu.tscn')
