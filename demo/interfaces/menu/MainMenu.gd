extends Control

export(String) var scene_path = ''


func _ready():
	$CenterContainer/VBoxContainer/Play.connect('pressed', self, '_on_Pressed')
	

func _on_Pressed():
	LevelManager.goto_scene('res://scenes/%s.tscn' % [scene_path])
