extends Node2D
class_name Slot


var is_occupied: bool = false
var docked_tile: Tile
var has_transformed: bool = false

@export var squares: Node2D
var game: Game

@export var color_rect: ColorRect

@export var dock_anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	if (game != null):
		squares.visible = game.is_holding_tile
		color_rect.visible = game.is_holding_tile && is_hovering

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62

func initialize(_game: Game) -> void:
	_game.slots.append(self)
	game = _game

func dock(tile: Tile) -> void:
	if (is_occupied):
		docked_tile.queue_free()
	tile.global_position = global_position
	tile.is_held = false
	is_occupied = true
	docked_tile = tile
	has_transformed = false
	dock_anim_player.stop()
	dock_anim_player.play("dock")

func undock() -> void:
	docked_tile = null
	is_occupied = false

func update_docked_tile_position() -> void:
	if (is_occupied):
		docked_tile.global_position = global_position
