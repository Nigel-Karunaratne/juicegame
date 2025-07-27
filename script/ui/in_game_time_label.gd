extends Label

func _ready() -> void:
	GlobalEventBus.sg_worldtime_change.connect(change_displayed_time)
	return

func change_displayed_time(new_time_str) -> void:
	text = new_time_str
	return
