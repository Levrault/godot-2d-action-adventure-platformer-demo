extends KinematicBody2D

onready var Physics2D: Node2D = $Physics2D

#warning-ignore:unused_class_variable
var velocity: Vector2 = Vector2()
var is_alive: bool = true
#warning-ignore:unused_class_variable
var gravity_enable: bool = true
#warning-ignore:unused_class_variable
var snap_enable: bool = false
#warning-ignore:unused_class_variable
var knockback_force: Vector2 = Vector2(0, 0)
#warning-ignore:unused_class_variable
var is_grounded: bool = false
#warning-ignore:unused_class_variable
var is_on_wall: bool = false


func _ready() -> void:
	$Health.connect('take_damage', self, '_on_getting_hit')
	$AttackCooldownTimer.connect('timeout', self, '_on_attack_cooldown')
	$AnimationPlayer.connect('animation_finished', self, '_on_animation_finish')
	$SightZone.connect('body_entered', self, '_on_player_sight')
	$SightZone.connect('body_exited', self, '_on_player_unsight')
	$AnimationPlayer.play('Idle')


func _physics_process(delta: float) -> void:
	Physics2D.compute_gravity(self, delta)


func _on_attack_cooldown() -> void:
	$AnimationPlayer.play('Attack')


#warning-ignore:unused_argument
func _on_getting_hit(alive: bool, direction: int) -> void:
	is_alive = alive
	if is_alive:
		$AnimationPlayer.play('GettingHit')
	else: 
		$AnimationPlayer.play('Death')


func _on_animation_finish(anim_name: String) -> void:
	if anim_name in ['Attack', 'GettingHit']:
		$AttackCooldownTimer.start()
		$AnimationPlayer.play('Idle')
	elif anim_name == 'Death':
		queue_free()


func _on_player_sight(body: Object) -> void:
	if body.get_collision_mask_bit(1):
		$AnimationPlayer.play('Attack')


func _on_player_unsight(body: Object) -> void:
	if body.get_collision_mask_bit(1):
		$AnimationPlayer.play('Idle')
		$AttackCooldownTimer.stop()