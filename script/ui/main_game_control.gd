class_name MainGameControl
extends Control

@export var map_button: Button

var map_resource: PackedScene = load("res://ui/menus/map_control.tscn")

# TEST FUNCTIONS, TO BE DELETED
# Example of how a dialogue event can be called and then reacted to
func _TBIND():
	GlobalEventBus.sg_start_dialogue_request.emit("event_name") # start a dialogue event
	GlobalEventBus.sg_dialogue_end.connect(_TBIND_EVENTEND) # what to do once it ends, could be used to unlock something or start another event
	return
func _TBIND_EVENTEND(event_name):
	print("'%s' over" % event_name)
	$TSTART.queue_free()
	return

func map_button_pressed() -> void:
	var _map = map_resource.instantiate()
	add_child(_map)
	return
