#warning-ignore-all:unused_class_variable
extends Character
class_name Player

# cache
onready var Physics2D: Node2D = $Physics2D
onready var CoolDownTimer: Timer = $CoolDownTimer


func _ready() -> void:
#	.set_states_map(override_states_map)
	
	
	# Signals
	$AnimationPlayer.connect('animation_finished', self, '_on_animation_finished')
	$Health.connect('take_damage', self, '_on_getting_hit')

	# set finish signal and construct states_map
	for state_node in $States.get_children():
		states_map[state_node.get_name()] = state_node
		state_node.connect('finished', self, '_change_state')

	# default states
	states_stack.push_front(states_map['Idle'])
	current_state = states_stack[0]
	_change_state('Idle')


# Delegate the call to the state
func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


# Connect to Health
func _on_getting_hit(alive: bool, direction: int) -> void:
	look_direction.x = direction
	is_alive = alive
	_change_state('GettingHit')


# Catch input
func _input(event: InputEvent) -> void:
	current_state.handle_input(self, event)


func game_over():
	#warning-ignore:return_value_discarded
	get_tree().change_scene("res://interfaces/GameOverInterface.tscn")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	current_state._on_animation_finished(anim_name, self)


func _on_CoolDownTimer_timeout():
	can_attack = true