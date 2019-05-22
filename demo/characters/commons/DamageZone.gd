extends Area2D
class_name DamageZone

#warning-ignore:unused_class_variable
export(float) var amount := 20.0 setget set_amount
export(String) var type_of_attack := 'Light' setget set_type_of_attack
export(bool) var has_slash := false
export(int, FLAGS) var MASK := 2
export(Vector2) var KNOCKBACK_FORCE := Vector2(5, 0)


func _ready():
	self.connect('body_entered', self, '_on_body_entered')


func set_type_of_attack(type):
	type_of_attack = type


func set_amount(new_amount):
	amount = new_amount


func _on_body_entered(body: Object) -> void:
	#	ennemy and player
	if body.get_collision_mask_bit(MASK) and not body.is_invincible:
		var direction: int = -1 if body.get_global_position() > get_parent().get_global_position() else 1
		body.knockback_force = KNOCKBACK_FORCE
		body.get_node('Health').take_damage(amount, direction)

		if has_slash:
			get_parent().get_node('Slash').slash(type_of_attack)

		print('%s atk hit %s' % [get_parent().get_name(), body.get_name()])
	