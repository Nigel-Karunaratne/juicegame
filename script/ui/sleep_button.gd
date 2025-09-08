class_name SleepButton
extends Button

func _ready() -> void:
	return


func _on_pressed() -> void:
	var _found_nodes = get_tree().get_nodes_in_group("DayTimer")
	if _found_nodes.size() < 1:
		push_error("ERROR [SleepButton]: No DayTimer found in group.")
		return
	elif _found_nodes.size() > 1:
		push_warning("WARNING [SleepButton]: Multiple nodes found in group 'DayTimer'.")
	var day_timer : DayTimer = _found_nodes[0]
	
	disabled = true
	day_timer.start_sleeping()
	# NOTE - start sleeping will need to wait for any UI updates (ex: global fade to black). so
	# the line below should run after that's all done - no need for a timer.
	disabled = false
	return
	
