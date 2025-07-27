"""
AreaManager

This Node keeps track of the different areas within the game, which ones are 
unlocked, which ones are accessible, and which ones the player can go to.

For now, these statuses are kept track in individual variables. If more flexibility is required,
a dictionary w/ enum as keys approach can be used. See commented section. 

Receives and emits signals from the GlobalEventBus.
"""

class_name AreaManager
extends Node


'''enum LOCATIONS { ROOM, GREENHOUSE, LAB, CONSTRUCITON_SITE, DUNGEON }

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
