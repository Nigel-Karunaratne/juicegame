class_name FarmResourceManager
extends Node

var co2_level = 100 #range 100 to 0
var humidity_level : int = 50 #range 100 to 0

func _ready() -> void:
	GlobalEventBus.sg_worldtime_hourchange.connect(_on_hour_change.unbind(1))
	return

func _on_hour_change() -> void:
	_change_co2_by(-5)
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
