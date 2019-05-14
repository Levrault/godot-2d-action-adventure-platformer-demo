extends State
class_name Motion


func get_input_direction() -> Vector2:
	var input_direction: Vector2 = Vector2()
	input_direction.x = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input_direction


func update_look_direction(host: Character, direction: Vector2, scale_multiplier: int = 1) -> void:
	if direction and host.look_direction != direction:
		host.look_direction = direction
	if not direction.x in [-1, 1]:
		return
	host.get_node('Sprite').set_scale(Vector2(direction.x * scale_multiplier, 1))
	host.get_node('States').set_scale(Vector2(direction.x * scale_multiplier, 1))


func move(host, input_direction: Vector2, speed: float, acceleration: float) -> void:
	host.velocity.x = lerp(host.velocity.x, host.look_direction.x * speed, acceleration) if input_direction else 0