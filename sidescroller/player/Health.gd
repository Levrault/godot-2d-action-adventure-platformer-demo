extends Node2D

signal health_changed(new_health)
signal max_health_changed(new_health)
signal take_damage(alive, direction)
signal momentum()

export(float) var max_health: float = 100
var health: float = 0


func _ready() -> void:
	health = max_health
	emit_signal('max_health_changed', max_health)
	emit_signal('health_changed', health)
	
	#warning-ignore:return_value_discarded
	self.connect('momentum', $'../Momentum', 'attack_momentum')


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('simulate_getting_hit'):
		take_damage(25, 1)


func take_damage(amount: float, direction: int) -> void:
	var is_alive: bool = true
	health -= amount
	if health <= 0:
		health = 0
		is_alive = false

	emit_signal('health_changed', health)
	emit_signal('take_damage', is_alive, direction)
	emit_signal('momentum')
	print('%s took %s damage. Health: %s/%s' % [get_path(), amount, health, max_health])


func recover_health(amount: float) -> void:
	health += amount
	if health > max_health:
		health = max_health
	emit_signal('health_changed', health)
	print('%s recovered %s health. Health: %s/%s' % [get_path(), amount, health, max_health])