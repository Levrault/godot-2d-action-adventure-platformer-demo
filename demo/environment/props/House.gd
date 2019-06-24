extends Sprite
class_name Interaction

signal interaction(type)

const ALERT_SCENE: Resource = preload('res://interfaces/dialogue/AlertBox.tscn')
const NEXT_ALERT_SCENE: Resource = preload('res://interfaces/dialogue/AlertNextLevelBox.tscn')
export(String) var scene_path = ''
export(bool) var is_last_level = false


func _ready():
	$AlertTrigger.connect('body_entered', self, '_on_body_enter')


func _on_body_enter(body: Object) -> void:
	if body.get_collision_mask_bit(1):
		if body.is_grounded:
			var alert_box = null
			if not is_last_level:
				alert_box = NEXT_ALERT_SCENE.instance() 
			else:
				alert_box = ALERT_SCENE.instance()
			
			alert_box.set_scene_path(scene_path)
			alert_box.position = $AlertBoxPosition.position
			self.add_child(alert_box)
			alert_box.start(body)
			emit_signal('interaction', 'WaitForAlertBox')