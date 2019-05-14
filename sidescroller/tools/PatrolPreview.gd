tool
extends Draw

func _draw():
	if not (DEBUG_MODE):
		return
	var parent = get_parent().get_parent()
	if parent.get(value):
		draw_circle_outline(parent.get(value), color)
	update()
