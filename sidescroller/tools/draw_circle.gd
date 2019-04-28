tool
extends Draw


func _draw():
	if not (DEBUG_MODE):
		return
	
	if get_parent().get_parent().get(value):
		draw_circle_outline(get_parent().get_parent().get(value), color)
	update()