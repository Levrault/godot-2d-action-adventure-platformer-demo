extends KinematicBody2D
class_name Slime

# state management
var current_state: State = null
var states_stack: Array = []

onready var states_map: Dictionary = {
	'Idle': $States/Idle,
	'Move': $States/Move,
	'Attack': $States/Attack,
	'Death': $States/Death
}


# cache
onready var Physics2D: Node2D = $Physics2D
onready var CoolDownTimer: Timer = $CoolDownTimer

# Player condition
var is_alive: bool = true
var can_attack: bool = true
var gravity_enable: bool = true

# velocity
var velocity: Vector2 = Vector2()
var look_direction: Vector2 = Vector2(1, 0)

# collision/physics states
var is_grounded: bool = false
var is_on_one_way_platform: bool = false
var is_on_wall: bool = false
var snap_enable: bool = false
var knockback_force: Vector2 = Vector2(0, 0)

# I.A.
var target: KinematicBody2D = null


func _ready() -> void:
	$AnimationPlayer.connect('animation_finished', self, '_on_AnimationPlayer_animation_finished')	
	$Health.connect('take_damage', self, '_on_getting_hit')
	$SightZone.connect('body_entered', self, '_on_player_sight')
	$SightZone.connect('body_exited', self, '_on_player_unsight')
	
	# state change
	for state_node in $States.get_children():
		state_node.connect('finished', self, '_change_state')

	# default states
	states_stack.push_front(states_map['Idle'])
	current_state = states_stack[0]
	_change_state('Idle')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


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


func _on_animation_finished(anim_name: String) -> void:
	current_state._on_animation_finished(anim_name, self)


func _on_player_sight(body: Object) -> void:
	pass
#	if body.get_collision_mask_bit(1):
#		target = body


func _on_player_unsight(body: Object) -> void:
	pass
#	if body.get_collision_mask_bit(1):
#		$AnimationPlayer.play('Idle')
# 		$CooldownTimer.stop()
#		target = null