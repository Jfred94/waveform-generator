extends GamePanel
class_name InventoryPanel

@export var game: Game

@export var locked_slot_texture: Texture2D
@export var unlocked_background_texture: Texture2D

@export var inventory: Inventory

@export var shrunk_tile_background_texture: Texture2D
@export var combined_tile_background_texture: Texture2D
@export var both_tile_background_texture: Texture2D

@export var hover_anim_player: AnimationPlayer

@export var diamond_source: TileSource
@export var rectangle_source: TileSource

@export var unlock_swing_value: float = 1.0
var unlock_actual_scroll_value: int = 0
var old_scroll_value: int = 0

@export var inventory_anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	if (unlock_swing_value < 1.0):
		inventory.scroll_container.scroll_vertical = lerpf(old_scroll_value, unlock_actual_scroll_value, unlock_swing_value)

func check_hovering() -> void:
	var was_hovering: bool = is_hovering
	is_hovering = get_local_mouse_position().x >= -346 && get_local_mouse_position().x <= 346 && get_local_mouse_position().y >= -306 && get_local_mouse_position().y <= 306
	if (is_hovering && !was_hovering):
		hover_anim_player.play("hover in")
		game.panel_hover_in_audio_stream_player.play()
	elif (!is_hovering && was_hovering):
		hover_anim_player.play("hover out")
		game.panel_hover_out_audio_stream_player.play()

func unlock_tile_source(shape_type: Game.Shape) -> void:
	if (inventory.tile_source_array[shape_type - 4].is_locked):
		inventory.tile_source_array[shape_type - 4].unlock()
		old_scroll_value = inventory.scroll_container.scroll_vertical
		if (shape_type >= 4 && shape_type <= 7):
			unlock_actual_scroll_value = 0
		elif (shape_type >= 8 && shape_type <= 11):
			unlock_actual_scroll_value = 160
		elif (shape_type >= 12 && shape_type <= 15):
			unlock_actual_scroll_value = 320
		elif (shape_type >= 16 && shape_type <= 19):
			unlock_actual_scroll_value = 480
		elif (shape_type >= 20 && shape_type <= 23):
			unlock_actual_scroll_value = 640
		elif (shape_type >= 24 && shape_type <= 27):
			unlock_actual_scroll_value = 800
		elif (shape_type >= 28 && shape_type <= 31):
			unlock_actual_scroll_value = 960
		elif (shape_type >= 32 && shape_type <= 35):
			unlock_actual_scroll_value = 1120
		elif (shape_type >= 36 && shape_type <= 39):
			unlock_actual_scroll_value = 1280
		else:
			unlock_actual_scroll_value = 1400
		inventory_anim_player.play("unlock")
		
