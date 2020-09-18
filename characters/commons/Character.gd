"""
Character will share common property between all inherited classes.
It init a finite state machine depending on the States node children.
e.g.
	State (Node2D)
	-- Idle (Node2D)
	-- Move (Node2D)

will automaticly create the state machine with Idle and Move state.
It also contains all the common physics/behavior state variable share between all 
character (player and mob).
"""
#warning-ignore-all:unused_class_variable
extends KinematicBody2D
class_name Character

# signal emitted when a the character change his state.
signal state_changed(new_state)

# finite state machine
onready var states_map: Dictionary = {}
var current_state: State = null
var states_stack: Array = []

# character condition
var is_alive: bool = true
var can_attack: bool = true
var gravity_enable: bool = true
var can_double_jump: bool = true
var is_invincible: bool = false
var has_set_next_attack: bool = false

# velocity
var velocity: Vector2 = Vector2()
var look_direction: Vector2 = Vector2(1, 0)

# collision/physics
var is_grounded: bool = false
var is_on_one_way_platform: bool = false
var is_on_wall: bool = false
var snap_enable: bool = false
var knockback_force: Vector2 = Vector2(0, 0)


"""
Populate state_map dictionary with character state.
e.g.
	State (Node2D)
	-- Idle (Node2D)
	-- Move (Node2D)
Will create {'Idle': Node2D, 'Move': Node2D}.

@param {String} initial_state - default state 
"""
func _initialize_state(initial_state: String = 'Idle'):
	# state change
	for state_node in $States.get_children():
		states_map[state_node.get_name()] = state_node
		state_node.connect('finished', self, '_change_state')
		
		# inactive damage zone by default since the are controller by the AnimationPlayer	
		if state_node.has_node('DamageZone'):
			state_node.get_node('DamageZone').set_monitoring(false)

	# default states
	states_stack.push_front(states_map[initial_state])
	current_state = states_stack[0]
	_change_state(initial_state)


"""
Change to a new state.

@param {String} state_name - next state
"""
func _change_state(state_name: String) -> void:
	current_state.exit(self)

	if state_name == 'Previous': # previous state
		states_stack.pop_front()
	elif state_name in ['GettingHit']: # pushdown automaton
		states_stack.push_front(states_map[state_name])
	else:
		var new_state = states_map[state_name]
		states_stack[0] = new_state

	current_state = states_stack[0]

	if current_state.get_name() != 'Previous':
		current_state.enter(self)

	emit_signal('state_changed', current_state.get_name())


"""
Delegate animaton_finish the to current state.

@param {String} anim_name
"""
func _on_Animation_finished(anim_name: String) -> void:
	current_state._on_Animation_finished(anim_name, self)


"""
Delegate animaton_finish the to current state.

@param {String} anim_name
"""
func _on_Cooldown_timeout():
	can_attack = true


"""
Remove from memory when the character died.
"""
func _on_Death() -> void:
	queue_free()
