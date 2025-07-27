"""
DayTimer

This is a Node that is responsible for tracking the in-game time.
Every 10 real-world minutes is 1 in-game day

CURRENTLY, the day starts at 00:00 and ends at 11:45. THIS SHOULD BE CHANGED LATER.

Receives and emits signals from the GlobalEventBus.
"""

class_name DayTimer
extends Node

var day_number : int = 1
var day_time : int = 0

var time_str : String = "00:00"

var real_seconds_per_quarter_hour : float = 6.25 # 1 hr = 25 seconds, 1 day (24 hrs) = 10 minutes

@onready var _change_timer : Timer = %ChangeTimer

func _ready() -> void:
	_change_timer.wait_time = real_seconds_per_quarter_hour
	_change_timer.timeout.connect(_on_timer_timeout)
	_change_timer.start()
	
	# Pause/Resume timer when dialogue starts/ends
	# Since the signals have parameters but the functions do not, we need to unbind them; otherwise, runtime error
	GlobalEventBus.sg_dialogue_start.connect(pause_timer.unbind(1))
	GlobalEventBus.sg_dialogue_end.connect(resume_timer.unbind(1))

func pause_timer() -> void:
	_change_timer.paused = true
	return

func resume_timer() -> void:
	_change_timer.paused = false
	return

func _on_timer_timeout() -> void:
	add_time(1)
	return

func add_time(in_game_seconds: int):
	day_time += in_game_seconds
	if day_time >= 24 * 4:  # For day being 24 hrs long and split up into 15-minute (1/4-hr) sections
		day_number += 1
		day_time = 0
	
	@warning_ignore("integer_division")
	time_str = "%02d:%02d" % [int(day_time / 4), day_time % 4 * 15]
	GlobalEventBus.sg_worldtime_change.emit(time_str)
	return
