extends GamePanel
class_name InfoPanel

@export var label: RichTextLabel

var info_string: String = "[wave amp=20 freq=1.0][b]INFO PANEL[/b]\nDetailed information about every part of the interface goes here\nHover over a panel to display its info[/wave]"
var visualizer_string: String = "[wave amp=20 freq=1.0][b]VISUALIZER[/b]\nThe created shape generates a waveform\nTry to match the example waveform in the background by adjusting the drawn shape[/wave]"
var hint_string: String = "[wave amp=20 freq=1.0][b]HINT PANEL[/b]\nHint 1: disables all panels and tiles that are not required to complete the waveform\nHint 2/3/4/5: reveals the solution for each corner tile[/wave]"
var inventory_string: String = "[wave amp=20 freq=1.0][b]INVENTORY PANEL[/b]\nAll shapes are catalogued here, click and hold to drag a tile out\nWhenever you discover a new shape, it will unlock in the inventory[/wave]"
var rotate_string: String = "[wave amp=20 freq=1.0][b]ROTATE PANEL[/b]\nInsert a tile here to rotate it 90 degrees clockwise[/wave]"
var shrink_string: String = "[wave amp=20 freq=1.0][b]SHRINK PANEL[/b]\nInsert a tile here to scale it down by half\nA tile that has already been scaled down cannot be scaled down again[/wave]"
var flip_string: String = "[wave amp=20 freq=1.0][b]FLIP PANEL[/b]\nInsert a tile here to flip it horizontally[/wave]"
var combine_string: String = "[wave amp=20 freq=1.0][b]COMBINE PANEL[/b]\nInsert 2 tiles here to combine them\nAdditive combine takes the longest point from the center\nExclusive combine takes the shortest point from the center\nA tile that has already been combined cannot be combined again[/wave]"
var shape_string: String = "[wave amp=20 freq=1.0][b]SHAPE PANEL[/b]\nInsert 4 tiles here to construct the visualizer shape\nIf a tile cannot be placed in this rotation, it will be highlighted in red[/wave]"


@export var visualizer: Visualizer
@export var hint_panel: HintPanel
@export var inventory_panel: InventoryPanel
@export var rotate_panel: RotatePanel
@export var shrink_panel: ShrinkPanel
@export var flip_panel: FlipPanel
@export var combine_panel: CombinePanel
@export var shape_panel: ShapePanel

@export var hover_anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = ""


var is_hovering: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	
	if (is_hovering):
		label.text = info_string
	elif (visualizer.is_hovering):
		label.text = visualizer_string
	elif (hint_panel.is_hovering):
		label.text = hint_string
	elif (inventory_panel.is_hovering):
		label.text = inventory_string
	elif (rotate_panel.is_hovering):
		label.text = rotate_string
	elif (shrink_panel.is_hovering):
		label.text = shrink_string
	elif (flip_panel.is_hovering):
		label.text = flip_string
	elif (combine_panel.is_hovering):
		label.text = combine_string
	elif (shape_panel.is_hovering):
		label.text = shape_string
	else:
		label.text = ""
	
	

func check_hovering() -> void:
	var was_hovering: bool = is_hovering
	is_hovering = get_local_mouse_position().x >= -446 && get_local_mouse_position().x <= 446 && get_local_mouse_position().y >= -126 && get_local_mouse_position().y <= 126
	if (is_hovering && !was_hovering):
		hover_anim_player.play("hover in")
	elif (!is_hovering && was_hovering):
		hover_anim_player.play("hover out")
