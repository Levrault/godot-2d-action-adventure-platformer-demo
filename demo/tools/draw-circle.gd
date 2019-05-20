tool
extends Draw


func _draw():
	if not ProjectSettings.get_setting('Debug/debug_mode'):
		return
	var parent = get_parent().get_parent()
	if parent.get(value):
		draw_circle_outline(parent.get(value), color)
	update()