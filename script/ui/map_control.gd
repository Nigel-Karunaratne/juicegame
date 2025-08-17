class_name MapControl
extends Control

@export var room_button : Button
@export var greenhouuse_button : Button
@export var lab_button : Button
@export var construction_site_button : Button
@export var dungeon_button : Button

var _area_access_tracker_ref : AreaAccessTracker

func _ready() -> void:
	var managers_in_group = get_tree().get_nodes_in_group("AreaAccessTracker")
	if managers_in_group.size() <= 0:
		push_error("ERROR [MapControl]: in _ready, found no nodes in 'AreaAccessTracker' group")
	else:
		if managers_in_group.size() > 1:
			push_warning("WARNING [MapControl]: in _ready, found >1 node in 'AreaAccessTracker' group")
		_area_access_tracker_ref = managers_in_group[0]
	
	_refresh_map_area_availability()
	return

# Disable btns for inactive areas / Set Status of buttons. As a separate fn for added flexability if needed later on.
func _refresh_map_area_availability() -> void:
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.ROOM):
		room_button.disabled = true
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.GREENHOUSE):
		greenhouuse_button.disabled = true
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.LAB):
		lab_button.disabled = true
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.CONSTRUCTION_SITE):
		construction_site_button.disabled = true
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.DUNGEON):
		dungeon_button.disabled = true
	
	# TODO - currently does NOT disable current area button. Player should not be able to swap to the same area!
	
	return

func lab_btn_pressed() -> void:
	# Even though btns were disabled before if area was locked, let's still check again to be safe.
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.LAB):
		return
	GlobalEventBus.sg_changearea_request.emit(AreaAccessTracker.LOCATIONS.LAB)
	return

func room_btn_pressed() -> void:
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.ROOM):
		return
	GlobalEventBus.sg_changearea_request.emit(AreaAccessTracker.LOCATIONS.ROOM)
	return

func greenhouse_btn_pressed() -> void:
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.GREENHOUSE):
		return
	GlobalEventBus.sg_changearea_request.emit(AreaAccessTracker.LOCATIONS.GREENHOUSE)
	return

func construction_site_btn_pressed() -> void:
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.CONSTRUCTION_SITE):
		return
	GlobalEventBus.sg_changearea_request.emit(AreaAccessTracker.LOCATIONS.CONSTRUCTION_SITE)
	return

func dungeon_btn_pressed() -> void:
	if not _area_access_tracker_ref.is_area_unlocked(AreaAccessTracker.LOCATIONS.DUNGEON):
		return
	GlobalEventBus.sg_changearea_request.emit(AreaAccessTracker.LOCATIONS.DUNGEON)
	return

func close_map_btn_pressed() -> void:
	queue_free()
	return
