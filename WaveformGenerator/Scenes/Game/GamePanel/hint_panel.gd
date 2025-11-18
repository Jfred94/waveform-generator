extends GamePanel
class_name HintPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()

func check_hovering() -> void:
	is_hovering = get_local_mouse_position().x >= -186 && get_local_mouse_position().x <= 186 && get_local_mouse_position().y >= -146 && get_local_mouse_position().y <= 146
