'''
PlayerVitals

This is a Node that is responsible for tracking player things like energy. Node should belong to a 
group for easy access to direct function calls (checking if player has enough energy for action, etc).

Like most resource handling nodes, PlayerVitals is not an autoload because it handles resources for a
game instance.

Receives and emits signals from the GlobalEventBus.
'''

class_name PlayerVitals
extends Node

var energy : int = 100 #max 100, can go down to zero

func _ready() -> void:
	GlobalEventBus.sg_worldtime_newday_ontime.connect(set_energy_new_day_on_time)
	GlobalEventBus.sg_worldtime_newday_sleepin.connect(set_energy_new_day_sleep_in)
	return

# ASSUMES player can only do an action if they have a certain amount of energy
# EX: Player has 5 energy, so they can only do things that cost 5 or less energy.
func can_do_any_action(value: int) -> bool:
	return energy >= value

func decrease_energy_by(value: int) -> void:
	return

func set_energy_new_day_on_time() -> void:
	energy = 100
	return

func set_energy_new_day_sleep_in() -> void:
	energy = 50
	return
