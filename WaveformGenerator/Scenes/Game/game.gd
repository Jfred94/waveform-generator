extends Node2D
class_name Game

enum Shape
{
	CIRCLE,
	SQUARE,
	DIAMOND,
	RECTANGLE,
	RECTANGLE_F,
	SMALL_CIRCLE,
	SMALL_SQUARE,
	SMALL_DIAMOND,
	SMALL_RECTANGLE,
	SMALL_RECTANGLE_F,
	CIRCLE_PLUS_RECTANGLE,
	CIRCLE_PLUS_RECTANGLE_F,
	DIAMOND_PLUS_RECTANGLE,
	DIAMOND_PLUS_RECTANGLE_F,
	RECTANGLE_PLUS_RECTANGLE_F,
	RECTANGLE_PLUS_INV_CIRCLE,
	RECTANGLE_F_PLUS_INV_CIRCLE,
	INV_CIRCLE_PLUS_SMALL_CIRCLE,
	INV_CIRCLE_PLUS_SMALL_SQUARE,
	INV_CIRCLE_PLUS_SMALL_RECTANGLE,
	INV_CIRCLE_PLUS_SMALL_RECTANGLE_F,
	SMALL_CIRCLE_PLUS_SMALL_RECTANGLE,
	SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F,
	SMALL_DIAMOND_PLUS_SMALL_RECTANGLE,
	SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F,
	SMALL_RECTANGLE_PLUS_SMALL_RECTANGLE_F,
	SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE,
	SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE,
	CIRCLE_X_RECTANGLE,
	CIRCLE_X_RECTANGLE_F,
	DIAMOND_X_RECTANGLE,
	DIAMOND_X_RECTANGLE_F,
	RECTANGLE_X_INV_CIRCLE,
	RECTANGLE_F_X_INV_CIRCLE,
	INV_CIRCLE_X_SMALL_CIRCLE,
	INV_CIRCLE_X_SMALL_SQUARE,
	INV_CIRCLE_X_SMALL_RECTANGLE,
	INV_CIRCLE_X_SMALL_RECTANGLE_F,
	SMALL_CIRCLE_X_SMALL_RECTANGLE,
	SMALL_CIRCLE_X_SMALL_RECTANGLE_F,
	SMALL_DIAMOND_X_SMALL_RECTANGLE,
	SMALL_DIAMOND_X_SMALL_RECTANGLE_F,
	SMALL_RECTANGLE_X_SMALL_RECTANGLE_F,
	SMALL_RECTANGLE_X_SMALL_INV_CIRCLE,
	SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE,
	EMPTY
}

@export var shape_textures: Array[Texture2D]
@export var tiles: Node2D

var slots: Array[Slot]

@export var inventory_panel: InventoryPanel

@export var music_slider: HSlider
@export var sfx_slider: HSlider

var music_bus_index = AudioServer.get_bus_index("Music")
var sfx_bus_index = AudioServer.get_bus_index("SFX")

var is_in_menu: bool = true
@export var new_button: TextureButton
@export var panels: Node2D
@export var level_manager: LevelManager
@export var shape_panel: ShapePanel
@export var anim_player: AnimationPlayer

var is_holding_tile: bool = false

@export var music_stream_player: AudioStreamPlayer
@export var music_loop_stream: AudioStream




@export var button_hover_in_audio_stream_player: AudioStreamPlayer
@export var button_hover_out_audio_stream_player: AudioStreamPlayer
@export var button_click_audio_stream_player: AudioStreamPlayer






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, music_slider.value)
	AudioServer.set_bus_volume_linear(sfx_bus_index, sfx_slider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_slider_mouse_exited() -> void:
	music_slider.release_focus()
	button_hover_out_audio_stream_player.play()




func _on_sfx_slider_mouse_exited() -> void:
	sfx_slider.release_focus()
	button_hover_out_audio_stream_player.play()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)


func _on_new_button_button_up() -> void:
	
	new_button.visible = false
	panels.position = Vector2.ZERO
	anim_player.play("new")

func on_shape_panel_appear() -> void:
	shape_panel.slot1.update_docked_tile_position()
	shape_panel.slot2.update_docked_tile_position()
	shape_panel.slot3.update_docked_tile_position()
	shape_panel.slot4.update_docked_tile_position()

func on_flash() -> void:
	level_manager.background.texture = level_manager.backgrounds[1]
	is_in_menu = false


func _on_music_stream_player_finished() -> void:
	music_stream_player.stream = music_loop_stream
	music_stream_player.play()


func _on_new_button_mouse_entered() -> void:
	button_hover_in_audio_stream_player.play()


func _on_new_button_mouse_exited() -> void:
	button_hover_out_audio_stream_player.play()


func _on_new_button_button_down() -> void:
	button_click_audio_stream_player.play()


func _on_music_slider_mouse_entered() -> void:
	button_hover_in_audio_stream_player.play()


func _on_music_slider_drag_started() -> void:
	button_click_audio_stream_player.play()


func _on_sfx_slider_mouse_entered() -> void:
	button_hover_in_audio_stream_player.play()


func _on_sfx_slider_drag_started() -> void:
	button_click_audio_stream_player.play()
