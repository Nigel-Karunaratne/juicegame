"""
AreaAccessTracker

This Node keeps track of the different areas within the game, which ones are 
unlocked, which ones are accessible, and which ones the player can go to.

For now, these statuses are kept track in individual variables. If more flexibility is required,
a dictionary w/ enum as keys approach can be used. See commented section. 

Receives and emits signals from the GlobalEventBus.
"""

class_name AreaAccessTracker
extends Node

enum LOCATIONS { ROOM, GREENHOUSE, LAB, CONSTRUCTION_SITE, DUNGEON }

'''
var unlocked_areas = {
	LOCATIONS.ROOM : true,
	LOCATIONS.GREENHOUSE : true,
	LOCATIONS.LAB : true,
	LOCATIONS.CONSTRUCITON_SITE : false,
	LOCATIONS.DUNGEON : false,
} '''

var unlocked_room : bool = true
var unlocked_greenhouse : bool = true
var unlocked_lab : bool = true
var unlocked_construction_site : bool = false
var unlocked_dungeon : bool = false

func is_area_unlocked(location: LOCATIONS) -> bool:
	match location:
		LOCATIONS.ROOM:
			return unlocked_room
		LOCATIONS.GREENHOUSE:
			return unlocked_greenhouse
		LOCATIONS.LAB:
			return unlocked_lab
		LOCATIONS.CONSTRUCTION_SITE:
			return unlocked_construction_site
		LOCATIONS.DUNGEON:
			return unlocked_dungeon
		var other_location:
			push_warning("WARNING [AreaManager]: is_area_unlocked invoked with unknown location '%s'" % str(other_location))
	return false
