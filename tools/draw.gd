tool
extends Node2D
class_name Draw

#warning-ignore:unused_class_variable
export (Color) var color = Color(255, 255, 255, 255)
#warning-ignore:unused_class_variable
export (String) var value = null

const POINTS_COUNT = 24

func _ready():
	if ProjectSettings.get_setting('Debug/debug_mode'):
		visible = true


func draw_circle_outline(radius: float, color: Color, offset:= Vector2(), line_width:=1.0) -> void:
	var points_array = PoolVector2Array()
	for i in range(POINTS_COUNT + 1):
		var angle = 2 * PI * i / POINTS_COUNT
		var point = offset + Vector2(cos(angle) * radius, sin(angle) * radius)
		points_array.append(point)
	draw_polyline(points_array, color, line_width, true)


#warning-ignore:unused_argument
func _process(delta):
	update()
