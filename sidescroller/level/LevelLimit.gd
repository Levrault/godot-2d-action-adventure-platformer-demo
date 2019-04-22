extends Area2D


func _ready():
	#warning-ignore:return_value_discarded
	self.connect('body_exited', self, '_on_body_exited')

 
func _on_body_exited(body) -> void:
	# player
	if body.get_collision_mask_bit(1):
		body.game_over()
		print('%s has instanced game over' % [body.get_name()])