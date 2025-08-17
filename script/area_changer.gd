"""
AreaChanger

This Node handes changing the area the player is in.

Receives and emits signals from the GlobalEventBus.
"""

class_name AreaChanger
extends Node

var _room_resource : PackedScene = preload("res://prefab/areas/room_area.tscn")
var _greenhouse_resource : PackedScene = preload("res://prefab/areas/greenhouse_area.tscn")
var _lab_resource : PackedScene = preload("res://prefab/areas/lab_area.tscn")
var _construction_site_resource : PackedScene = preload("res://prefab/areas/construction_site_area.tscn")
var _dungeon_resource : PackedScene = preload("res://prefab/areas/dungeon_area.tscn")

# SHOULD BE SET IN INSPECTOR, THIS IS THE DEFAULT ROOM THAT'S ALREADY THERE
@export var _current_area_ref : Node2D

func _ready() -> void:
	GlobalEventBus.sg_changearea_request.connect(_change_area)
	return

func _change_area(new_area: AreaAccessTracker.LOCATIONS) -> void:
	print("changing to ", new_area)
	var _instantiated_area : Node2D
	
	GlobalEventBus.sg_changearea_start.emit(new_area)
	
	match new_area:
		AreaAccessTracker.LOCATIONS.ROOM: 
			_instantiated_area = _room_resource.instantiate()
		AreaAccessTracker.LOCATIONS.GREENHOUSE: 
			_instantiated_area = _greenhouse_resource.instantiate()
		AreaAccessTracker.LOCATIONS.LAB: 
			_instantiated_area = _lab_resource.instantiate()
		AreaAccessTracker.LOCATIONS.CONSTRUCTION_SITE: 
			_instantiated_area = _construction_site_resource.instantiate()
		AreaAccessTracker.LOCATIONS.DUNGEON: 
			_instantiated_area = _dungeon_resource.instantiate()
		var _other_location:
			push_error("ERROR [AreaChanger]: provided area to change to '%s' is invalid. Not changing areas." % str(new_area))
			return
	# Transition
	# TODO - transition is instantaneous here. Add fade outs or other animation here.
	_current_area_ref.queue_free()
	
	get_tree().root.add_child(_instantiated_area)
	_instantiated_area.add_to_group("Area") # NOTE - i forgot why we have a node group for current area
	_current_area_ref = _instantiated_area
	
	return
