extends VisibilityNotifier2D


func _ready() -> void:
	self.connect('screen_exited', self, '_on_player_screen_exited')


func _on_player_screen_exited() -> void:
	get_tree().change_scene('res://interfaces/GameOverInterface.tscn')