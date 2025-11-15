extends Node2D
class_name TileSource

@export var shape_type: Game.Shape

@export var shape_sprite: Sprite2D
@export var inventory_panel: InventoryPanel
var game: Game

var tile_scene = preload("res://Scenes/Game/Tile/tile.tscn")
var tiles: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = inventory_panel.game
	shape_sprite.texture = game.shape_textures[shape_type]
	tiles = game.tiles

var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	
	if (is_hovering && Input.is_action_just_pressed("lmb")):
		spawn_tile()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func spawn_tile() -> void:
	var tile: Tile = tile_scene.instantiate()
	tiles.add_child(tile)
	tile.global_position = get_global_mouse_position()
	tile.initialize(shape_type, true, game)
