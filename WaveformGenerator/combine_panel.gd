extends GamePanel
class_name CombinePanel


@export var slot1: Slot
@export var slot2: Slot
@export var slot3: Slot
@export var game: Game

var tile_scene = preload("res://Scenes/Game/Tile/tile.tscn")
var tiles: Node2D

@export var hover_anim_player: AnimationPlayer

@export var additive_button: TextureButton
@export var exclusive_button: TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot1.initialize(game)
	slot2.initialize(game)
	tiles = game.tiles


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()

func check_hovering() -> void:
	var was_hovering: bool = is_hovering
	is_hovering = get_local_mouse_position().x >= -406 && get_local_mouse_position().x <= 406 && get_local_mouse_position().y >= -146 && get_local_mouse_position().y <= 146
	if (is_hovering && !was_hovering):
		hover_anim_player.play("hover in")
	elif (!is_hovering && was_hovering):
		hover_anim_player.play("hover out")















func _on_additive_button_button_up() -> void:
	if (slot1.is_occupied && slot2.is_occupied):
		var t1: Game.Shape = slot1.docked_tile.shape_type
		var t2: Game.Shape = slot2.docked_tile.shape_type
		var t3: Game.Shape = Game.Shape.EMPTY
		var r3: Tile.ShapeRotation = slot1.docked_tile.shape_rotation
		
		if (slot1.docked_tile.shape_rotation == slot2.docked_tile.shape_rotation):
			if (t1 == Game.Shape.CIRCLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.CIRCLE_PLUS_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.CIRCLE_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.CIRCLE
				else:
					pass
			elif (t1 == Game.Shape.SQUARE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SQUARE
				else:
					pass
			elif (t1 == Game.Shape.DIAMOND):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.DIAMOND
				else:
					pass
			elif (t1 == Game.Shape.RECTANGLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE_PLUS_RECTANGLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE
				else:
					pass
			elif (t1 == Game.Shape.RECTANGLE_F):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_CIRCLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_SQUARE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_SQUARE
				else:
					pass
			elif (t1 == Game.Shape.SMALL_DIAMOND):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_RECTANGLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE_PLUS_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
		elif (slot1.docked_tile.shape_rotation + 180 == slot2.docked_tile.shape_rotation || slot1.docked_tile.shape_rotation - 180 == slot2.docked_tile.shape_rotation):
			if (t1 == Game.Shape.CIRCLE):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE_PLUS_INV_CIRCLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F_PLUS_INV_CIRCLE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t2 == Game.Shape.CIRCLE):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE_PLUS_INV_CIRCLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F_PLUS_INV_CIRCLE
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_CIRCLE
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_SQUARE
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.INV_CIRCLE_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_CIRCLE):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE
				else:
					pass
			elif (t2 == Game.Shape.SMALL_CIRCLE):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_PLUS_SMALL_INV_CIRCLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F_PLUS_SMALL_INV_CIRCLE
				else:
					pass
			elif (t1 == Game.Shape.DIAMOND):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.DIAMOND
				else:
					pass
			elif (t2 == Game.Shape.DIAMOND):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_PLUS_RECTANGLE_F
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.DIAMOND
				else:
					pass
			elif (t1 == Game.Shape.SMALL_DIAMOND):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			elif (t2 == Game.Shape.SMALL_DIAMOND):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_PLUS_SMALL_RECTANGLE_F
				else:
					pass
			else:
				pass
		else:
			pass
		
		
		if (t3 == Game.Shape.EMPTY):
			pass
		else:
			slot1.docked_tile.destroy()
			slot2.docked_tile.destroy()
			var tile: Tile = tile_scene.instantiate()
			tiles.add_child(tile)
			tile.position = position + Vector2(140, 0)
			tile.initialize(t3, false, game)
			tile.shape_rotation = r3
			tile.update_shape()
			tile.docked_slot = slot3
			slot3.dock(tile)
		

















func _on_exclusive_button_button_up() -> void:
	if (slot1.is_occupied && slot2.is_occupied):
		var t1: Game.Shape = slot1.docked_tile.shape_type
		var t2: Game.Shape = slot2.docked_tile.shape_type
		var t3: Game.Shape = Game.Shape.EMPTY
		var r3: Tile.ShapeRotation = slot1.docked_tile.shape_rotation
		
		if (slot1.docked_tile.shape_rotation == slot2.docked_tile.shape_rotation):
			if (t1 == Game.Shape.CIRCLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.CIRCLE_X_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.CIRCLE_X_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SQUARE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.DIAMOND):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.RECTANGLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE_X_RECTANGLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.RECTANGLE_F):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE_X_RECTANGLE_F
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE_F
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_CIRCLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_SQUARE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_DIAMOND):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_RECTANGLE):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE_X_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_X_SMALL_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
		elif (slot1.docked_tile.shape_rotation + 180 == slot2.docked_tile.shape_rotation || slot1.docked_tile.shape_rotation - 180 == slot2.docked_tile.shape_rotation):
			if (t1 == Game.Shape.CIRCLE):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE_X_INV_CIRCLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F_X_INV_CIRCLE
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t2 == Game.Shape.CIRCLE):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.RECTANGLE_X_INV_CIRCLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.RECTANGLE_F_X_INV_CIRCLE
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_CIRCLE
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_SQUARE
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.INV_CIRCLE_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_CIRCLE):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot1.docked_tile.shape_rotation
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_X_SMALL_INV_CIRCLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE
				else:
					pass
			elif (t2 == Game.Shape.SMALL_CIRCLE):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_CIRCLE
					r3 = slot2.docked_tile.shape_rotation
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE_X_SMALL_INV_CIRCLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F_X_SMALL_INV_CIRCLE
				else:
					pass
			elif (t1 == Game.Shape.DIAMOND):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE_F
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t2 == Game.Shape.DIAMOND):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.DIAMOND_X_RECTANGLE_F
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_CIRCLE
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_SQUARE
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_RECTANGLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_RECTANGLE_F
				else:
					pass
			elif (t1 == Game.Shape.SMALL_DIAMOND):
				r3 = slot2.docked_tile.shape_rotation
				if (t2 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t2 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE
				elif (t2 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F
				else:
					pass
			elif (t2 == Game.Shape.SMALL_DIAMOND):
				r3 = slot1.docked_tile.shape_rotation
				if (t1 == Game.Shape.CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_CIRCLE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_SQUARE):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_DIAMOND):
					t3 = Game.Shape.SMALL_DIAMOND
				elif (t1 == Game.Shape.SMALL_RECTANGLE):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE
				elif (t1 == Game.Shape.SMALL_RECTANGLE_F):
					t3 = Game.Shape.SMALL_DIAMOND_X_SMALL_RECTANGLE_F
				else:
					pass
			else:
				pass
		else:
			pass
		
		
		if (t3 == Game.Shape.EMPTY):
			pass
		else:
			slot1.docked_tile.destroy()
			slot2.docked_tile.destroy()
			var tile: Tile = tile_scene.instantiate()
			tiles.add_child(tile)
			tile.position = position + Vector2(140, 0)
			tile.initialize(t3, false, game)
			tile.shape_rotation = r3
			tile.update_shape()
			tile.docked_slot = slot3
			slot3.dock(tile)
