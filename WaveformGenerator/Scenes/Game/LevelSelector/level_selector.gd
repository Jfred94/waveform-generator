extends Node2D
class_name LevelSelector

@export var level_n: Texture2D
@export var level_h: Texture2D
@export var level_p: Texture2D

var buttons: Array[TextureButton]
@export var buttons_node: Node2D

@export var agencyfb_b: FontFile

@export var level_manager: LevelManager

@export var selector: Sprite2D

@export var level_anim_player: AnimationPlayer
@export var square_anim_player: AnimationPlayer
@export var scaling_square: Sprite2D

@export var game: Game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(25):
		var button: TextureButton = TextureButton.new()
		buttons.append(button)
		buttons_node.add_child(button)
		button.texture_normal = level_n
		button.texture_hover = level_h
		button.texture_pressed = level_p
		button.z_index = 460
		
		var rtl: RichTextLabel = RichTextLabel.new()
		button.add_child(rtl)
		rtl.bbcode_enabled = true
		rtl.text = "[wave amp=20 freq=1.0]" + str(i + 1) + "[/wave]"
		rtl.fit_content = true
		rtl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		rtl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		rtl.size = Vector2(60, 60)
		rtl.add_theme_font_override("normal_font", agencyfb_b)
		rtl.add_theme_font_size_override("normal_font_size", 48)
		rtl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
		button.position = Vector2(-180 + (i % 5) * 80, -180 + int(i / 5) * 80)
		button.button_up.connect(func(): _on_button_up(button))
		button.name = str(i+1)
		
		button.mouse_entered.connect(_on_button_mouse_entered)
		button.mouse_exited.connect(_on_button_mouse_exited)
		button.button_down.connect(_on_button_button_down)

var is_hovering: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	is_hovering = get_local_mouse_position().x >= -220 && get_local_mouse_position().x <= 220 && get_local_mouse_position().y >= -220 && get_local_mouse_position().y <= 220
	if (level_manager.level < 26):
		selector.position = Vector2(-190 + ((level_manager.level - 1) % 5) * 80, -190 + int((level_manager.level - 1) / 5) * 80)
		selector.visible = true
	else:
		selector.visible = false

func _on_button_up(button: TextureButton) -> void:
	level_manager.load_level(int(button.name))

func on_finish(_level: int) -> void:
	buttons[_level - 1].get_child(0).modulate = Color(0.541, 0.569, 1.0)
	level_anim_player.play("finish")
	scaling_square.position = Vector2(-150 + ((level_manager.level - 1) % 5) * 80, -150 + int((level_manager.level - 1) / 5) * 80)
	square_anim_player.play("scale")

func _on_button_mouse_entered() -> void:
	game.button_hover_in_audio_stream_player.play()


func _on_button_mouse_exited() -> void:
	game.button_hover_out_audio_stream_player.play()


func _on_button_button_down() -> void:
	game.button_click_audio_stream_player.play()
