extends Area2D
class_name DamageZone

#warning-ignore:unused_class_variable
export(float) var amount = 20


func _ready():
	#warning-ignore:return_value_discarded
	self.connect('body_entered', self, '_on_body_entered')


#warning-ignore:unused_argument
func _on_body_entered(body: KinematicBody2D) -> void:
	print('%s atk hit %s' % [get_parent().get_name(), body.get_name()])