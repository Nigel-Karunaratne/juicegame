extends Node

func swap_to_scene(scene_path: String, with_fade: bool = true) -> void:
	# TODO - obtain resource? preload? async?
	
	if with_fade:
		GlobalUiEventBus.sgui_fade_to_black.emit()
	
	# TODO - load/delay
	var lvl: PackedScene = load(scene_path)
	
	var err: Error = get_tree().change_scene_to_packed(lvl)
	if err != OK:
		push_error("ERROR: %s" % err)
	
	if with_fade:
		GlobalUiEventBus.sgui_fade_to_screen.emit()
	return
