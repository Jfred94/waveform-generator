extends GamePanel
class_name RotatePanel


@export var slot: Slot
@export var game: Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot.initialize(game)


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	check_transformation()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -146 && get_local_mouse_position().x <= 146 && get_local_mouse_position().y >= -146 && get_local_mouse_position().y <= 146

func check_transformation() -> void:
	if (slot.is_occupied && !slot.has_transformed):
		transform_tile(slot.docked_tile)

func transform_tile(tile: Tile) -> void:
	slot.has_transformed = true
	if (slot.docked_tile.shape_rotation == Tile.ShapeRotation.TOP_LEFT):
		slot.docked_tile.shape_rotation = Tile.ShapeRotation.TOP_RIGHT
	elif (slot.docked_tile.shape_rotation == Tile.ShapeRotation.TOP_RIGHT):
		slot.docked_tile.shape_rotation = Tile.ShapeRotation.BOTTOM_RIGHT
	elif (slot.docked_tile.shape_rotation == Tile.ShapeRotation.BOTTOM_RIGHT):
		slot.docked_tile.shape_rotation = Tile.ShapeRotation.BOTTOM_LEFT
	else:
		slot.docked_tile.shape_rotation = Tile.ShapeRotation.TOP_LEFT
	slot.docked_tile.update_shape()
