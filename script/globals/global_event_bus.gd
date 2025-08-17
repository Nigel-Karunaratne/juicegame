class_name GameEventBus
extends Node

@warning_ignore_start("unused_signal") # So we don't get tons of warnings about unused signals

signal sg_start_dialogue_request(event_name)
signal sg_dialogue_end(event_name)
signal sg_dialogue_start(event_name)

signal sg_worldtime_change(new_time_as_str) # Emitted when the time in-game changes.
signal sg_worldtime_hourchange(new_time_as_str) # Emitted when the time in-game progresses to the next hour
signal sg_worldtime_datechange(new_date_as_str) # Emitted when the date in-game changes

signal sg_changearea_request(location_as_enum) # Emitted when a node, like the Map, wants to change area.
signal sg_changearea_start(location_as_enum) # Emitted when the AreaChanges starts changing areas

@warning_ignore_restore("unused_signal")
