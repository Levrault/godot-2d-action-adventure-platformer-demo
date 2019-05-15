extends Motion


# pixels/sec
export (float) var SPEED:= 75
export (float) var ACCELERATION:= 1
var direction: int = -1


func enter(host: Eagle) -> void:
	host.get_node('AnimationPlayer').play('Patrol')


#warning-ignore:unused_argument
func update(host: Eagle, delta: float) -> void:
	if host.position.x < host.min_distance:
		direction = 1
	elif host.position.x > host.max_distance:
		direction = -1
	
	update_look_direction(host, Vector2(direction, 0), -1)
	move(host, Vector2(direction, 0), SPEED, ACCELERATION)