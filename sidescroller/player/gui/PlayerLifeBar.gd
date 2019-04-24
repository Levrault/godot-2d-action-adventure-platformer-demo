extends TextureRect


func _ready():
	get_parent().get_parent().get_node('Health').connect('health_changed', self, '_on_Health_changed')


func _on_Health_changed(health_value):
	$TextureProgress.update_value(health_value)