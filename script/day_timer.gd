"""
DayTimer

This is a Node that is responsible for tracking the in-game time.
Every 10 real-world minutes is 1 in-game day (8am-12am period) - each in-game 15-minute period is 9.375 seconds

Day int [0, 683] (687 days in a year)
Month int [0,11] = day // 57 (57 days per month)
Season int [0,3] = 0 if month == 11 else (month + 1) // 3 (3 months per season, december, jan, feb are meteorlogical winter, every 3 months are new season)
Year int [2500, inf]

Receives and emits signals from the GlobalEventBus.
"""

class_name DayTimer
extends Node

var time : int = 32
var day : int = 0
var month : int = 0
var season : int = 0
var year : int = 2500

var date_str : String = "DD MMM YYYY (SEASON)"
var time_str : String = "00:00"

var real_seconds_per_quarter_hour : float = 9.375 # 1 hr = 37.5 seconds, 16 hrs (8am-midnight) = 600 seconds = 10 minutes
#OLD: 6.25 # 1 hr = 25 seconds, 1 day (24 hrs) = 10 minutes

@onready var _change_timer : Timer = %ChangeTimer

const MONTH_INT_TO_STR = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
var SEASON_INT_TO_STR = ["WINTER", "SPRING", "SUMMER", "FALL"]

func _ready() -> void:
	_change_timer.wait_time = real_seconds_per_quarter_hour
	_change_timer.timeout.connect(_on_timer_timeout)
	_change_timer.start()
	
	time_str = "%02d:%02d" % [int(time / 4), time % 4 * 15]
	date_str = "%d %s %04d (%s)" % [day + 1, MONTH_INT_TO_STR[month].substr(0,3), year, SEASON_INT_TO_STR[month]]
	
	# Pause/Resume timer when dialogue starts/ends
	# Since the signals have parameters but the functions do not, we need to unbind them; otherwise, runtime error
	GlobalEventBus.sg_dialogue_start.connect(pause_timer.unbind(1))
	GlobalEventBus.sg_dialogue_end.connect(resume_timer.unbind(1))
	
	# Force the UI to show the proper date. HOWEVER, due to load order, we need to delay this by a bit
	await get_tree().process_frame
	print('emitting')
	GlobalEventBus.sg_worldtime_datechange.emit(date_str)
	GlobalEventBus.sg_worldtime_hourchange.emit(time_str)

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
	time += in_game_seconds
	if time >= 24 * 4:  # For day being 24 hrs long and split up into 15-minute (1/4-hr) sections
		# TODO - NOTE that if the time ever reaches this point, player needs to be forcefully put to sleep and wake up later.
		move_to_next_day(14 * 4) # 8 * 4 for 8AM wakeup, 14 * 4 for 14:00 (2PM) wakeup
		return
	
	@warning_ignore("integer_division")
	time_str = "%02d:%02d" % [int(time / 4), time % 4 * 15]
	GlobalEventBus.sg_worldtime_change.emit(time_str)
	
	if time % 4 == 0:
		# New hour, emit signal
		GlobalEventBus.sg_worldtime_hourchange.emit(time_str)
	return

func move_to_next_day(starting_time: int) -> void:
	day += 1
	@warning_ignore("integer_division")
	month = int(day / 57)
	@warning_ignore("integer_division")
	season = 0 if month == 11 else int((month + 1) / 3)
	if month > 11:
		year += 1
	date_str = "%d %s $04d (%s)" % [day + 1, MONTH_INT_TO_STR[month].substr(0,3), year, SEASON_INT_TO_STR[month]]
	
	time = starting_time
	@warning_ignore("integer_division")
	time_str = "%02d:%02d" % [int(time / 4), time % 4 * 15]
	
	# NOTE - currently do NOT emit signals for time change and hour change, but do emit signal for day change
	GlobalEventBus.sg_worldtime_datechange.emit(date_str)
	return
