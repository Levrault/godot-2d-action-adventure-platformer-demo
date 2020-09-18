extends Node2D

export(String) var scene_path = ''
var min_limit: Vector2 = Vector2()
var max_limit: Vector2 = Vector2()

func _ready():
	$World/Player.connect('player_position_changed', self, '_on_Player_position_changed')
	$World/Player.connect('player_death', self, '_on_Player_death')
	LevelManager.set_scene_path(scene_path)
	min_limit = $Bounds/Min.position
	max_limit = $Bounds/Max.position

	# camera limits are based on global pixels, so we'll get the absolute position of our bounds to set the limits, 
	# and use relative to compare to the player's relative position
	# Thanks to Razoric for this solution !
	var global_min = $Bounds/Min.global_position
	var global_max = $Bounds/Max.global_position
	$World/Player/Camera.limit_left = global_min.x
	$World/Player/Camera.limit_right = global_max.x
	$World/Player/Camera.limit_top = global_max.y
	$World/Player/Camera.limit_bottom = global_min.y


func _on_Player_position_changed(new_position: Vector2) -> void:
	if new_position.x < min_limit.x or new_position.y > min_limit.y or new_position.x > max_limit.x:
		_on_Player_death()


func _on_Player_death() -> void:
	$World/Player.queue_free()
	$World/Enemies.queue_free()
	$Ambiance/Music.stop()
	$Interfaces/GameOver.show()
