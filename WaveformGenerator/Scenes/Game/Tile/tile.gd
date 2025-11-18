extends Node2D
class_name Tile


var shape_type: Game.Shape
@export var shape_sprite: Sprite2D
var is_held: bool
var game: Game

var docked_slot: Slot

enum ShapeRotation
{
	TOP_LEFT = 0,
	TOP_RIGHT = 90,
	BOTTOM_RIGHT = 180,
	BOTTOM_LEFT = 270
}

var shape_rotation: ShapeRotation = ShapeRotation.TOP_LEFT

@export var background: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_background()


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_held):
		check_hovering()
		if (is_hovering && Input.is_action_just_pressed("lmb")):
			is_held = true
			docked_slot.undock()
	else:
		hold()
			

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func initialize(_shape_type: Game.Shape, _is_held: bool, _game: Game) -> void:
	shape_type = _shape_type
	is_held = _is_held
	game = _game
	shape_sprite.texture = game.shape_textures[shape_type]
	update_background()

func hold() -> void:
	global_position = get_global_mouse_position()
	z_index = 75
	if (Input.is_action_just_released("lmb")):
		z_index = 70
		is_held = false
		var hovered_slot_id: int = -1
		for i in range(game.slots.size()):
			if (get_global_mouse_position().x >= game.slots[i].global_position.x - 62 && get_global_mouse_position().x <= game.slots[i].global_position.x + 62 && get_global_mouse_position().y >= game.slots[i].global_position.y - 62 && get_global_mouse_position().y <= game.slots[i].global_position.y + 62):
				hovered_slot_id = i
		if (hovered_slot_id == -1):
			destroy()
		else:
			docked_slot = game.slots[hovered_slot_id]
			docked_slot.dock(self)

func update_shape() -> void:
	shape_sprite.texture = game.shape_textures[shape_type]
	shape_sprite.rotation_degrees = shape_rotation
	update_background()
	if (shape_type >= 4):
		game.inventory_panel.unlock_tile_source(shape_type)

func update_background() -> void:
	if (shape_type == Game.Shape.SMALL_CIRCLE || shape_type == Game.Shape.SMALL_SQUARE || shape_type == Game.Shape.SMALL_DIAMOND || shape_type == Game.Shape.SMALL_RECTANGLE || shape_type == Game.Shape.SMALL_RECTANGLE_F):
		background.texture = game.inventory_panel.shrunk_tile_background_texture
	elif (shape_type == Game.Shape.CIRCLE_PLUS_RECTANGLE || shape_type == Game.Shape.CIRCLE_PLUS_RECTANGLE_F || shape_type == Game.Shape.DIAMOND_PLUS_RECTANGLE || shape_type == Game.Shape.DIAMOND_PLUS_RECTANGLE_F || shape_type == Game.Shape.RECTANGLE_PLUS_RECTANGLE_F || shape_type == Game.Shape.RECTANGLE_PLUS_INV_CIRCLE || shape_type == Game.Shape.RECTANGLE_F_PLUS_INV_CIRCLE || shape_type == Game.Shape.CIRCLE_X_RECTANGLE || shape_type == Game.Shape.CIRCLE_X_RECTANGLE_F || shape_type == Game.Shape.DIAMOND_X_RECTANGLE || shape_type == Game.Shape.DIAMOND_X_RECTANGLE_F || shape_type == Game.Shape.RECTANGLE_X_INV_CIRCLE || shape_type == Game.Shape.RECTANGLE_F_X_INV_CIRCLE):
		background.texture = game.inventory_panel.combined_tile_background_texture
	elif (shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_CIRCLE || shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_SQUARE || shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE || shape_type == Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE || shape_type == Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE || shape_type == Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE || shape_type == Game.Shape.SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE || shape_type == Game.Shape.INV_CIRCLE_X_SMALL_CIRCLE || shape_type == Game.Shape.INV_CIRCLE_X_SMALL_SQUARE || shape_type == Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE || shape_type == Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE || shape_type == Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE || shape_type == Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_RECTANGLE_X_SMALL_RECTANGLE_F || shape_type == Game.Shape.SMALL_RECTANGLE_X_SMALL_INV_CIRCLE || shape_type == Game.Shape.SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE):
		background.texture = game.inventory_panel.both_tile_background_texture

func destroy() -> void:
	if (docked_slot != null):
		docked_slot.undock()
	queue_free()
