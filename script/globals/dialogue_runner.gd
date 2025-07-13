class_name DialogueRunner
extends Control

const DIALOGUE_JSON : String = "res://text/dialogue_example.json"

var showing_dialogue: bool = false
var current_entries = []
var current_event_key: String

var json_data

@export var ui_name_label: Label
@export var ui_text_label: Label

func _ready() -> void:
	GlobalEventBus.sg_start_dialogue_request.connect(start_dialogue)
	visible = false
	load_text()
	return

func load_text() -> void:
	var file = FileAccess.open(DIALOGUE_JSON, FileAccess.READ) # NOTE - GDScript, files are auto-closed when they go out of scope
	if FileAccess.get_open_error() != OK:
		push_error("ERROR: DialogueRunner cannot load the file '%s'." % DIALOGUE_JSON)
		return
	var _loaded_json = JSON.new()
	var parse_err = _loaded_json.parse(file.get_as_text())
	if parse_err != OK:
		push_error("ERROR: DialogueRunner could not parse '%s', even though it was loaded." % DIALOGUE_JSON)
		return
	json_data = _loaded_json.data
	return

func start_dialogue(event_key: String) -> void:
	if showing_dialogue:
		push_error("ERROR: DialogueRunner recieved request to start event '%s' but another event is being played!" % event_key)
		return
	var _lang = OS.get_locale_language()
	
	if event_key not in json_data:
		push_error("ERROR: DialogueRunner: event '%s' does not exist." % event_key)
		return
	
	if _lang not in json_data[event_key]:
		# Since it is possible for us to not have things translated (by mistake), we alert the user
		# instead of not running the event as that could softlock people
		current_entries.push_front(["Error!", "This event '%s' has not been translated into language '%s' yet. Pardon our dust." % [event_key, _lang] ])
	else:
		for line in json_data[event_key][_lang]:
			current_entries.push_front(line) #push front here bc front needs to re-index everything.
	
	# TODO - show UI
	self.visible = true
	
	current_event_key = event_key
	show_next_line()
	return

func show_next_line():
	var data = current_entries.pop_back()
	if data == null:
		# TODO - hide UI
		self.visible = false
		showing_dialogue = false
		GlobalEventBus.sg_dialogue_end.emit(current_event_key)
		return
	ui_name_label.text = data[0]
	ui_text_label.text = data[1]
	return
