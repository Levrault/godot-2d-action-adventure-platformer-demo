tool
extends Draw


func _draw():
	if not ProjectSettings.get_setting('Debug/debug_mode'):
		return
	if Engine.editor_hint:
		draw_line($Min.position, Vector2($Max.position.x, $Min.position.y), color, 1)
		draw_line(Vector2($Max.position.x, $Min.position.y), $Max.position, color, 1)
		draw_line($Max.position, Vector2($Min.position.x, $Max.position.y), color, 1)
		draw_line(Vector2($Min.position.x, $Max.position.y), $Min.position, color, 1)
	update()