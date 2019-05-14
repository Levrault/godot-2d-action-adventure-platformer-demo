tool
extends Draw

var from := Vector2()
var to := Vector2()
var parent = null

func _ready():
	parent = get_parent().get_parent()
	if parent.get(value):
		from = self.position
		to = Vector2(parent.position.x + parent.get(value), 0)


func _draw():
	if not (DEBUG_MODE):
		return

	if Engine.editor_hint:
		parent = get_parent().get_parent()
		if parent.get(value):
			from = self.position
			to = Vector2(parent.position.x + parent.get(value), 0)
			draw_line(from, to, color, 2)
	else:
		draw_line(from, to, color, 2)
		
	update()