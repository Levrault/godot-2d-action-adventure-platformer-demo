#warning-ignore-all:unused_argument
#warning-ignore-all:unused_signal

"""
Base interface for all states: it doesn't do anything in itself
but forces us to pass the right arguments to the methods below
and makes sure every State object had all of these methods.
"""
extends Node
class_name State


signal finished(next_state_name)


func _ready():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)


# Initialize the state. E.g. change the animation
func enter(host):
	pass


# Clean up the state. Reinitialize values like a timer
func exit(host):
	pass


func handle_input(host, event):
	pass


func update(host, delta: float):
	pass


func _on_animation_finished(anim_name: String):
	pass


func play_sound(host, stream: Resource) -> void:
	host.get_node('AudioStreamPlayer').stream = stream
	host.get_node('AudioStreamPlayer').play()