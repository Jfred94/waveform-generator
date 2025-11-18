extends GamePanel
class_name HintPanel


@export var hover_anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()

func check_hovering() -> void:
	var was_hovering: bool = is_hovering
	is_hovering = get_local_mouse_position().x >= -186 && get_local_mouse_position().x <= 186 && get_local_mouse_position().y >= -146 && get_local_mouse_position().y <= 146
	if (is_hovering && !was_hovering):
		hover_anim_player.play("hover in")
	elif (!is_hovering && was_hovering):
		hover_anim_player.play("hover out")
