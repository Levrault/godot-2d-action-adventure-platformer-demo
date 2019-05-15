extends Area2D
class_name DamageZone

#warning-ignore:unused_class_variable
export(float) var amount := 20.0 setget set_amount
export(int, FLAGS) var MASK := 2
export(Vector2) var KNOCKBACK_FORCE := Vector2(5, 0)


func _ready():
	#warning-ignore:return_value_discarded
	self.connect('body_entered', self, '_on_body_entered')


func set_amount(new_amount):
	amount = new_amount


#warning-ignore:unused_argument
func _on_body_entered(body: Object) -> void:
	#	ennemy and player
	if body.get_collision_mask_bit(MASK):
		var direction: Vector2 = (body.get_global_position() - get_parent().get_global_position()).normalized()
		body.knockback_force = KNOCKBACK_FORCE
		body.get_node('Health').take_damage(amount, direction.x)
		print('%s atk hit %s' % [get_parent().get_name(), body.get_name()])
	