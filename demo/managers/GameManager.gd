extends Node2D

var min_limit: Vector2 = Vector2()
var max_limit: Vector2 = Vector2()

func _ready():
	$World/Player.connect('player_position_changed', self, '_on_player_position_changed')
	min_limit = $Bounds/Min.position
	max_limit = $Bounds/Max.position


func _on_player_position_changed(new_position: Vector2):
	if new_position.x < min_limit.x or new_position.y > min_limit.y or new_position.x > max_limit.x:
		get_tree().change_scene('res://interfaces/GameOverInterface.tscn')