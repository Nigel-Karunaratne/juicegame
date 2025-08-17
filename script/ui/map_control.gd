class_name MapControl
extends Control

@export var room_button : Button
@export var greenhouuse_button : Button
@export var lab_button : Button
@export var construction_site_button : Button
@export var dungeon_button : Button

var _area_manager_reference : AreaManager

func _ready() -> void:
	var managers_in_group = get_tree().get_nodes_in_group("AreaManager")
	if managers_in_group.size() <= 0:
		push_error("ERROR [MapControl]: in _ready, found no nodes in 'AreaManager' group")
	else:
		if managers_in_group.size() > 1:
			push_warning("WARNING [MapControl]: in _ready, found >1 node in 'AreaManager' group")
		_area_manager_reference = managers_in_group[0]
	
	_refresh_map_area_availability()
	return

# Disable btns for inactive areas / Set Status of buttons. As a separate fn for added flexability if needed later on.
func _refresh_map_area_availability() -> void:
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.ROOM):
		room_button.disabled = true
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.GREENHOUSE):
		greenhouuse_button.disabled = true
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.LAB):
		lab_button.disabled = true
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.CONSTRUCTION_SITE):
		construction_site_button.disabled = true
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.DUNGEON):
		dungeon_button.disabled = true
	
	return

func lab_btn_pressed() -> void:
	# Even though btns were disabled before if area was locked, let's still check again to be safe.
	if not _area_manager_reference.is_area_unlocked(AreaManager.LOCATIONS.ROOM):
		return
	#AreaChange.change
	return

func room_btn_pressed() -> void:
	return

func greenhouse_btn_pressed() -> void:
	return

func construction_site_btn_pressed() -> void:
	return

func dungeon_btn_pressed() -> void:
	return

func close_map_btn_pressed() -> void:
	queue_free()
	return
