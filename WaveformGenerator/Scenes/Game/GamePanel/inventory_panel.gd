extends GamePanel
class_name InventoryPanel

@export var game: Game

@export var locked_slot_texture: Texture2D
@export var unlocked_background_texture: Texture2D

@export var inventory: Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func unlock_tile_source(shape_type: Game.Shape) -> void:
	if (inventory.tile_source_array[shape_type - 4].is_locked):
		inventory.tile_source_array[shape_type - 4].unlock()
