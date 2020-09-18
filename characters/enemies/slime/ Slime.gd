extends Character
class_name Slime

# cache
onready var Physics2D: Node2D = $Physics2D

# I.A.
#warning-ignore:unused_class_variable
var has_target: bool = false
var target_position: Vector2 = Vector2()

const TARGET_MIN_DISTANCE: float = 20.0
const FOLLOW_RANGE: float = 100.0
const ATTACK_RANGE: float = 30.0


func _ready() -> void:
	# signal
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')
	$Health.connect('take_damage', self, '_on_Getting_hit')
	$CooldownTimer.connect('timeout', self, '_on_Cooldown_timeout')
	$States/Death/Explosion.connect('exploded', self, '_on_Death')
	
	if get_tree().get_root().has_node('Game/World/Player'):
		get_tree().get_root().get_node('Game/World/Player').connect('player_position_changed', self, '_on_player_position_changed')
	
	# state change
	._initialize_state()


# Connect to Health
func _on_Getting_hit(alive: bool, direction: int) -> void:
	look_direction.x = direction
	is_alive = alive
	if alive: 
		_change_state('GettingHit')
	else: 
		_change_state('Death')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)


func _on_player_position_changed(new_position: Vector2) -> void:
	target_position = new_position
	has_target = position.distance_to(target_position) <= FOLLOW_RANGE
