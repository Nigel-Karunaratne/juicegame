class_name FarmItemButton
extends TextureButton

@export var texture_to_use : Texture2D
@export var is_active : bool = false

func _ready() -> void:
	refresh_state()
	
	print(disabled)
	return

func change_texture(new_texture: Texture2D) -> void:
	texture_to_use = new_texture
	refresh_state()
	return

func set_enable(value: bool) -> void:
	is_active = true
	refresh_state()

func refresh_state() -> void:
	(self as TextureButton).disabled = not is_active
	
	texture_normal = texture_to_use
	texture_pressed = texture_to_use
	texture_hover = texture_to_use
	texture_disabled = texture_to_use
	texture_focused = texture_to_use
	return

func _on_pressed() -> void:
	
	return
