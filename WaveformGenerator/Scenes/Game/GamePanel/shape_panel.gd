extends GamePanel
class_name ShapePanel


@export var slot1: Slot
@export var slot2: Slot
@export var slot3: Slot
@export var slot4: Slot
@export var game: Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot1.initialize(game)
	slot2.initialize(game)
	slot3.initialize(game)
	slot4.initialize(game)


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -62 && get_local_mouse_position().x <= 62 && get_local_mouse_position().y >= -62 && get_local_mouse_position().y <= 62
