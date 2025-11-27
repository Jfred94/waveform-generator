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

@export var destroy_anim_player: AnimationPlayer

var is_destroying: bool = false

@export var bl: Sprite2D
@export var tr: Sprite2D

@export var transform_anim_player: AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_background()


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_destroying):
		if (!is_held):
			check_hovering()
			if (is_hovering && Input.is_action_just_pressed("lmb")):
				is_held = true
				docked_slot.undock()
		else:
			hold(delta)
	
	bl.visible = is_hovering && !is_held && !is_destroying
	tr.visible = is_hovering && !is_held && !is_destroying
	
	if (shape_sprite.rotation_degrees - shape_rotation > 180):
		shape_sprite.rotation_degrees -= 360
	shape_sprite.rotation_degrees = lerpf(shape_sprite.rotation_degrees, shape_rotation, delta * 50.0)
	

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62
	

func initialize(_shape_type: Game.Shape, _is_held: bool, _game: Game) -> void:
	shape_type = _shape_type
	is_held = _is_held
	game = _game
	shape_sprite.texture = game.shape_textures[shape_type]
	update_background()

func hold(delta: float) -> void:
	global_position = Vector2(lerpf(global_position.x, get_global_mouse_position().x, delta * 30), lerpf(global_position.y, get_global_mouse_position().y, delta * 30))
	z_index = 2175
	modulate = Color.WHITE
	game.is_holding_tile = true
	if (Input.is_action_just_released("lmb")):
		z_index = 1170
		is_held = false
		game.is_holding_tile = false
		var hovered_slot_id: int = -1
		var hovered_slot_ids: Array[int]
		for i in range(game.slots.size()):
			if (get_global_mouse_position().x >= game.slots[i].global_position.x - 124 && get_global_mouse_position().x <= game.slots[i].global_position.x + 124 && get_global_mouse_position().y >= game.slots[i].global_position.y - 124 && get_global_mouse_position().y <= game.slots[i].global_position.y + 124):
				hovered_slot_ids.append(i)
		if (hovered_slot_ids.size() == 0):
			destroy()
			return
		elif (hovered_slot_ids.size() == 1):
			hovered_slot_id = hovered_slot_ids[0]
		else:
			print("sdfsdf")
			var closest_slot_id: int = hovered_slot_ids[0]
			for i in range(hovered_slot_ids.size()):
				if (game.slots[hovered_slot_ids[i]].global_position.distance_to(get_global_mouse_position()) < game.slots[closest_slot_id].global_position.distance_to(get_global_mouse_position())):
					closest_slot_id = hovered_slot_ids[i]
			hovered_slot_id = closest_slot_id
		docked_slot = game.slots[hovered_slot_id]
		docked_slot.dock(self)
		

func update_shape() -> void:
	shape_sprite.texture = game.shape_textures[shape_type]
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
	destroy_anim_player.play("destroy")
	is_destroying = true

func on_destroy_anim_end() -> void:
	queue_free()

func initialize_as_combined() -> void:
	destroy_anim_player.play("create")
