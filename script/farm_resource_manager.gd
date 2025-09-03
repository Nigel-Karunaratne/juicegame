"""
FarmResourceManager

This is a Node that is responsible for managing farming mechanics, like:
	- C02 and Humidity
	- Planted Crops
	- What tiles are open for planting

Node should belong to a group for function access by other scripts. Specifically, the greenhouse UI
can get a reference to this node and call functions.

Receives and emits signals from the GlobalEventBus.
"""

class_name FarmResourceManager
extends Node

var co2_level = 100 #range 100 to 0
var humidity_level : int = 50 #range 100 to 0

var unlocked_tiles = 1 #range 1-9

# TODO - farming things
var planted_crops: Array = []

func _ready() -> void:
	GlobalEventBus.sg_worldtime_hourchange.connect(_on_hour_change.unbind(1))
	GlobalEventBus.sg_worldtime_change.connect(_on_time_change.unbind(1))
	return

func _on_hour_change() -> void:
	# Change CO2
	# TODO - change humidity if needed
	_change_co2_by(-5)
	return

func _on_time_change() -> void:
	# TODO - update plant growth information
	return

func _change_humidity_by(amount : int) -> void:
	humidity_level = clamp(humidity_level + amount, 0, 100)
	return

func _change_co2_by(ammount: int):
	co2_level = clamp(co2_level + ammount, 0, 100)
	return

func inject_random_co2() -> void:
	var co2_to_add := randi() % 10 + 10 #add a random value between 10 and 20
	
	if co2_to_add + co2_level > 100:
		co2_level = 100
	else:
		co2_level += co2_to_add
	return
