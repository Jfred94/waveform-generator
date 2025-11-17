extends GamePanel
class_name ShapePanel


@export var slot1: Slot
@export var slot2: Slot
@export var slot3: Slot
@export var slot4: Slot
@export var game: Game

var tile_scene = preload("res://Scenes/Game/Tile/tile.tscn")
var tiles: Node2D

@export var visualizer: Visualizer

@export var spinny_spinny: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot1.initialize(game)
	slot2.initialize(game)
	slot3.initialize(game)
	slot4.initialize(game)
	
	tiles = game.tiles
	
	var tile1: Tile = tile_scene.instantiate()
	tiles.add_child(tile1)
	tile1.position = position + Vector2(-80, -80)
	tile1.initialize(Game.Shape.CIRCLE, false, game)
	tile1.shape_rotation = Tile.ShapeRotation.TOP_LEFT
	tile1.update_shape()
	tile1.docked_slot = slot1
	slot1.dock(tile1)
	
	var tile2: Tile = tile_scene.instantiate()
	tiles.add_child(tile2)
	tile2.position = position + Vector2(80, -80)
	tile2.initialize(Game.Shape.CIRCLE, false, game)
	tile2.shape_rotation = Tile.ShapeRotation.TOP_RIGHT
	tile2.update_shape()
	tile2.docked_slot = slot2
	slot2.dock(tile2)
	
	var tile3: Tile = tile_scene.instantiate()
	tiles.add_child(tile3)
	tile3.position = position + Vector2(80, 80)
	tile3.initialize(Game.Shape.CIRCLE, false, game)
	tile3.shape_rotation = Tile.ShapeRotation.BOTTOM_RIGHT
	tile3.update_shape()
	tile3.docked_slot = slot3
	slot3.dock(tile3)
	
	var tile4: Tile = tile_scene.instantiate()
	tiles.add_child(tile4)
	tile4.position = position + Vector2(-80, 80)
	tile4.initialize(Game.Shape.CIRCLE, false, game)
	tile4.shape_rotation = Tile.ShapeRotation.BOTTOM_LEFT
	tile4.update_shape()
	tile4.docked_slot = slot4
	slot4.dock(tile4)
	
	visualizer.update_shapes(tile1, tile2, tile3, tile4)


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	
	visualizer.update_shapes(slot1.docked_tile, slot2.docked_tile, slot3.docked_tile, slot4.docked_tile)
	
	update_spinny_spinny()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func update_spinny_spinny():
	if (visualizer.angle >= 0.0 && visualizer.angle < PI * 0.5):
		spinny_spinny.position = Vector2(-82, -82)
		spinny_spinny.rotation = 0.0
	elif (visualizer.angle >= PI * 0.5 && visualizer.angle < PI):
		spinny_spinny.position = Vector2(82, -82)
		spinny_spinny.rotation = PI * 0.5
	elif (visualizer.angle >= PI && visualizer.angle < PI * 1.5):
		spinny_spinny.position = Vector2(82, 82)
		spinny_spinny.rotation = PI
	else:
		spinny_spinny.position = Vector2(-82, 82)
		spinny_spinny.rotation = PI * 1.5
