extends Label

func _ready() -> void:
	print('connecting')
	GlobalEventBus.sg_worldtime_datechange.connect(change_displayed_date)
	return

func change_displayed_date(new_date_str) -> void:
	print('chanign')
	text = new_date_str
	return
