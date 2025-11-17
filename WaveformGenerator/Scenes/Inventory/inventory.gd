extends Node2D
class_name Inventory

@export var inventory_panel: InventoryPanel
@export var vbox_container: VBoxContainer

@export var tile_source_array: Array[TileSource]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(vbox_container.get_children().size()):
		for j in range(vbox_container.get_child(i).get_children().size()):
			var tile_source: TileSource = vbox_container.get_child(i).get_child(j)
			tile_source.initialize(inventory_panel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
