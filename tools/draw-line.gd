tool
extends Draw

var from: Vector2 = Vector2()
var to: Vector2 = Vector2()
var parent = null


func _draw():
	if not ProjectSettings.get_setting('Debug/debug_mode'):
		return
	if Engine.editor_hint:
		parent = get_parent().get_parent()
		if parent.get(value):
			from = Vector2()
			to = Vector2(-parent.get(value), 0)
			draw_line(from, to, color, 2)
		
	update()