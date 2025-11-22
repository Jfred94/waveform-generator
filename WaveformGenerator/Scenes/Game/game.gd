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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, music_slider.value)
	AudioServer.set_bus_volume_linear(sfx_bus_index, sfx_slider.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_slider_mouse_exited() -> void:
	music_slider.release_focus()




func _on_sfx_slider_mouse_exited() -> void:
	sfx_slider.release_focus()


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(music_bus_index, value)


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)
