class_name CO2Manager
extends Node

var co2_level = 100 #range 100 to 0

func _ready() -> void:
	GlobalEventBus.sg_worldtime_hourchange.connect(_on_hour_change.unbind(1))
	return

func _on_hour_change() -> void:
	_decrease_co2(5)
	return

func _decrease_co2(ammount: int):
	var new_co2 = co2_level - ammount
	if new_co2 < 0:
		co2_level = 0
	else:
		co2_level = new_co2
	return

func inject_random_co2() -> void:
	var co2_to_add := randi() % 10 + 10 #add a random value between 10 and 20
	
	if co2_to_add + co2_level > 100:
		co2_level = 100
	else:
		co2_level += co2_to_add
	return
