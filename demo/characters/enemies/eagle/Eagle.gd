extends Character
class_name Eagle

# cache
onready var Physics2D: Node2D = $Physics2D

export (float) var patrol_distance = 200.0
var min_distance := 0.0
var max_distance := 0.0

func _ready() -> void:
	# signal
	$AnimationPlayer.connect('animation_finished', self, '_on_Animation_finished')	
	$Health.connect('take_damage', self, '_on_getting_hit')
	$CooldownTimer.connect('timeout', self, '_on_Cooldown_timeout')
	$States/Death/Explosion.connect('exploded', self, '_on_Death')
	
	gravity_enable = false
	
	min_distance = position.x - patrol_distance
	max_distance = position.x
	
	# state change
	._initialize_state('Patrol')


# Connect to Health
func _on_getting_hit(alive: bool, direction: int) -> void:
	look_direction.x = direction
	is_alive = alive
	if alive: 
		_change_state('GettingHit')
	else: 
		_change_state('Death')


func _physics_process(delta: float) -> void:
	current_state.update(self, delta)
	Physics2D.compute_gravity(self, delta)
