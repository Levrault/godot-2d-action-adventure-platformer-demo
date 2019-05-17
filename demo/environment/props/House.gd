extends Sprite
class_name Interaction

signal interaction(type)

const ALERT_SCENE: Resource = preload('res://interfaces/dialogue/AlertBox.tscn')


func _ready():
	$AlertTrigger.connect('body_entered', self, '_on_body_enter')


func _on_body_enter(body: Object) -> void:
	if body.get_collision_mask_bit(1):
		if body.is_grounded:
			var alert_box = ALERT_SCENE.instance()
			alert_box.position = $AlertBoxPosition.get_global_position()
			get_tree().get_root().add_child(alert_box)
			alert_box.start(body)
			emit_signal('interaction', 'WaitForAlertBox')