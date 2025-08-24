class_name DialogueOptionButton
extends Button

var next_event: String = ""
var set_flag: String = ""

@onready var _animation_player : AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	GlobalEventBus.sg_dialogue_option_selected_start_anim.connect(_on_option_selected)
	return

func _on_pressed() -> void:
	# TODO - set the flag
	GlobalEventBus.sg_dialogue_option_selected_start_anim.emit()
	
	# Start Animation
	_animation_player.play("dialogue_btn_selected")
	_animation_player.animation_finished.connect(_on_anim_player_finish)
	return

# SO that no other option can be selected during anim.
func _on_option_selected():
	self.disabled = true
	return

func _on_anim_player_finish(name: String) -> void:
	GlobalEventBus.sg_dialogue_option_selected_end_anim.emit()
	if next_event != "":
		GlobalEventBus.sg_start_dialogue_request.emit(next_event)
	return
