class_name DialogueOptionButton
extends Button

var next_event: String = ""
var set_flag: String = ""

func _on_pressed() -> void:
	# TODO - set the flag
	GlobalEventBus.sg_dialogue_option_selected.emit()
	# Wait one frame? uncomment this if the next dialogue does NOT start after the first one ends.
	# await get_tree().process_frame
	if next_event != "":
		GlobalEventBus.sg_start_dialogue_request.emit(next_event)
	return
