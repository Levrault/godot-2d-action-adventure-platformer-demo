#warning-ignore-all:unused_class_variable
extends KinematicBody2D
class_name Player

signal state_changed

# state management
var current_state: State = null
var states_stack: Array = []

onready var states_map: Dictionary = {
	'Idle': $States/Idle,
	'Move': $States/Move,
	'Jump': $States/Jump,
	'Fall': $States/Fall,
	'AttackLight': $States/AttackLight,
	'AttackMedium': $States/AttackMedium,
	'AttackHeavy': $States/AttackHeavy,
	'CombatIdle': $States/CombatIdle,
	'TidySword': $States/TidySword,
	'GettingHit': $States/GettingHit,
	'Death': $States/Death
}

# cache
onready var Physics2D: Node2D = $Physics2D
onready var CoolDownTimer: Timer = $CoolDownTimer

# Player condition
var is_alive: bool = true
var can_attack: bool = true

# velocity
var velocity: Vector2 = Vector2()
var look_direction: Vector2 = Vector2(1, 0)

# collision/physics states
var is_grounded: bool = false
var is_on_one_way_platform: bool = false
var is_on_wall: bool = false
var snap_enable: bool = false
var gravity_enable: bool = true
var knockback_force: Vector2 = Vector2(0, 0)

# combo
var has_set_next_attack: bool = false


func _ready() -> void:
	#warning-ignore:return_value_discarded
	$AnimationPlayer.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')	
	#warning-ignore:return_value_discarded
	$Health.connect('take_damage', self, '_on_getting_hit')

	# state change
	for state_node in $States.get_children():
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


# Exit the current state, change it and enter the new one
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

	emit_signal('state_changed', states_stack)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	current_state._on_animation_finished(anim_name, self)


func _on_CoolDownTimer_timeout():
	can_attack = true
