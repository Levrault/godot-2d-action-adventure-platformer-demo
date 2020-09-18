extends Control

export(String) var scene_path = ''


func _ready() -> void:
	$CenterContainer/VBoxContainer/Play.connect('pressed', self, '_on_Play_pressed')
	$CenterContainer/VBoxContainer/Credits.connect('pressed', self, '_on_Credit_pressed')
	$CenterContainer/VBoxContainer/Quit.connect('pressed', self, '_on_Quit_pressed')
	

func _on_Play_pressed() -> void:
	LevelManager.goto_scene('res://scenes/%s.tscn' % [scene_path])


func _on_Credit_pressed() -> void:
	get_tree().change_scene('res://interfaces/menu/Credits.tscn')
	
	
func _on_Quit_pressed() -> void:
	get_tree().quit()
