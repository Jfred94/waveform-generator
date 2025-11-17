extends Node2D
class_name TileSource

@export var shape_type: Game.Shape

@export var shape_sprite: Sprite2D
@export var inventory_panel: InventoryPanel
var game: Game

var tile_scene = preload("res://Scenes/Game/Tile/tile.tscn")
var tiles: Node2D

var is_locked: bool = false
@export var background: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (inventory_panel != null):
		game = inventory_panel.game
		shape_sprite.texture = game.shape_textures[shape_type]
		tiles = game.tiles

func initialize(_inventory_panel: InventoryPanel) -> void: # only called if in scrollable inventory, which means locked by default
	inventory_panel = _inventory_panel
	game = inventory_panel.game
	background.texture = inventory_panel.locked_slot_texture
	shape_sprite.texture = null
	tiles = game.tiles
	is_locked = true

var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	
	if (is_hovering && Input.is_action_just_pressed("lmb") && !is_locked):
		spawn_tile()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func spawn_tile() -> void:
	var tile: Tile = tile_scene.instantiate()
	tiles.add_child(tile)
	tile.global_position = get_global_mouse_position()
	tile.initialize(shape_type, true, game)

func unlock() -> void:
	is_locked = false
	background.texture = inventory_panel.unlocked_background_texture
	shape_sprite.texture = game.shape_textures[shape_type]
