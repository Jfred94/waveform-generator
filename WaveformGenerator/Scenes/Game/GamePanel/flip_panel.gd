extends GamePanel
class_name FlipPanel


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
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62


func check_transformation() -> void:
	if (slot.is_occupied && !slot.has_transformed):
		transform_tile(slot.docked_tile)

func transform_tile(tile: Tile) -> void:
	slot.has_transformed = true
	if (slot.docked_tile.shape_type == Game.Shape.RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.CIRCLE_PLUS_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.CIRCLE_PLUS_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.CIRCLE_PLUS_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.CIRCLE_PLUS_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.DIAMOND_PLUS_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.DIAMOND_PLUS_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.DIAMOND_PLUS_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.DIAMOND_PLUS_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.RECTANGLE_PLUS_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE_F_PLUS_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.RECTANGLE_F_PLUS_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE_PLUS_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.CIRCLE_X_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.CIRCLE_X_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.CIRCLE_X_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.CIRCLE_X_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.DIAMOND_X_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.DIAMOND_X_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.DIAMOND_X_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.DIAMOND_X_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.RECTANGLE_X_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE_F_X_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.RECTANGLE_F_X_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.RECTANGLE_X_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F):
		slot.docked_tile.shape_type = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE_X_SMALL_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE
	elif (slot.docked_tile.shape_type == Game.Shape.SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE):
		slot.docked_tile.shape_type = Game.Shape.SMALL_RECTANGLE_X_SMALL_INV_CIRCLE
	else:
		pass
	slot.docked_tile.update_shape()
