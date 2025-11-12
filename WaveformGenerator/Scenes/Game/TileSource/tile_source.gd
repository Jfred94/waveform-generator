extends Node2D

@export var shape_type: Game.Shape

@export var shape_sprite: Sprite2D
@export var inventory_panel: InventoryPanel
var game: Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game = inventory_panel.game
	shape_sprite.texture = game.shape_textures[shape_type]
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
