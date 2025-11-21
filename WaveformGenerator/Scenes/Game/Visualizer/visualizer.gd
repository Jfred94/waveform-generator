extends Node2D
class_name Visualizer

var tile1: Tile
var tile2: Tile
var tile3: Tile
var tile4: Tile

@export var static_circle: Sprite2D
@export var shape_circle: Sprite2D
@export var waveform_1_circle: Sprite2D
@export var waveform_2_circle: Sprite2D

var top_left_shape: int = 0
var top_right_shape: int = 0
var bottom_right_shape: int = 0
var bottom_left_shape: int = 0

var angle: float = 0.0
var radius: float = 160.0

@export var shape_line2D: Line2D
var visualizer_angle: float = 0.0
var is_shape_line_finished = false

@export var cord_line2D: Line2D

var is_first_waveform: bool = true # bool that dictates which waveform is currently playing over the other

@export var waveform_1_line2D_1: Line2D
@export var waveform_1_line2D_2: Line2D
@export var waveform_2_line2D_1: Line2D
@export var waveform_2_line2D_2: Line2D

@export var link_line2D_1: Line2D
@export var link_line2D_2: Line2D

@export var purple_gradient_thingy_h: Sprite2D
@export var purple_gradient_thingy_v: Sprite2D
@export var spinny_spinny: Sprite2D

var debug_mode: bool = false

var shape_line_ghost_scene = preload("res://Scenes/Game/ShapeLineGhost/shape_line_ghost.tscn")

@export var level_manager: LevelManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (debug_mode):
		waveform_1_circle.visible = false
		waveform_2_circle.visible = false
		link_line2D_1.visible = false
		link_line2D_2.visible = false
		purple_gradient_thingy_h.visible = false
		purple_gradient_thingy_v.visible = false
		

var is_hovering: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_hovering()
	angle += delta * PI * 0.5
	if (angle >= 2.0 * PI):
		angle -= 2.0 * PI
		is_first_waveform = !is_first_waveform
		if (is_first_waveform):
			waveform_1_line2D_1.clear_points()
			waveform_2_line2D_1.clear_points()
		else:
			waveform_1_line2D_2.clear_points()
			waveform_2_line2D_2.clear_points()
		level_manager.end_of_cycle()
	
	visualizer_angle += delta * PI * 0.5
	if (visualizer_angle >= 2.0 * PI):
		visualizer_angle -= 2.0 * PI
		is_shape_line_finished = true
		shape_line2D.closed = true
	
	
	
	var shape_index: int
	if (angle >= 0.0 && angle < PI * 0.5):
		shape_index = top_left_shape
		purple_gradient_thingy_v.position = Vector2(320, 0)
		purple_gradient_thingy_h.position = Vector2(0, -320)
		spinny_spinny.position = Vector2(-82, -82)
		spinny_spinny.rotation = 0.0
	elif (angle >= PI * 0.5 && angle < PI):
		shape_index = top_right_shape
		purple_gradient_thingy_v.position = Vector2(480, 0)
		purple_gradient_thingy_h.position = Vector2(0, -480)
		spinny_spinny.position = Vector2(82, -82)
		spinny_spinny.rotation = PI * 0.5
	elif (angle >= PI && angle < PI * 1.5):
		shape_index = bottom_right_shape
		purple_gradient_thingy_v.position = Vector2(640, 0)
		purple_gradient_thingy_h.position = Vector2(0, -640)
		spinny_spinny.position = Vector2(82, 82)
		spinny_spinny.rotation = PI
	else:
		shape_index = bottom_left_shape
		purple_gradient_thingy_v.position = Vector2(800, 0)
		purple_gradient_thingy_h.position = Vector2(0, -800)
		spinny_spinny.position = Vector2(-82, 82)
		spinny_spinny.rotation = PI * 1.5
	shape_circle.position = find_outside_position(angle, shape_index)
	
	waveform_1_circle.position = Vector2(240 + angle * (320 / PI), shape_circle.position.y)
	waveform_2_circle.position = Vector2(shape_circle.position.x, -240 - angle * (320 / PI))
	
	update_lines()


func check_hovering() -> void:
	is_hovering = (get_local_mouse_position().x >= -200 && get_local_mouse_position().x <= 200 && get_local_mouse_position().y >= -880 && get_local_mouse_position().y <= 200) || (get_local_mouse_position().x >= -200 && get_local_mouse_position().x <= 880 && get_local_mouse_position().y >= -200 && get_local_mouse_position().y <= 200)

func update_shapes(_tile1: Tile, _tile2: Tile, _tile3: Tile, _tile4: Tile) -> void:
	
	if (tile1 == _tile1 && tile2 == _tile2 && tile3 == _tile3 && tile4 == _tile4):
		return
	else:
		tile1 = _tile1
		tile2 = _tile2
		tile3 = _tile3
		tile4 = _tile4
		visualizer_angle = 0.0
		
		var shape_line_ghost: ShapeLineGhost = shape_line_ghost_scene.instantiate()
		add_child(shape_line_ghost)
		shape_line_ghost.z_index = -1
		shape_line_ghost.add_child(shape_line2D.duplicate())
		
		shape_line2D.clear_points()
		is_shape_line_finished = false
		shape_line2D.closed = false
		
		if (tile1 != null):
			tile1.modulate = Color.WHITE
		if (tile2 != null):
			tile2.modulate = Color.WHITE
		if (tile3 != null):
			tile3.modulate = Color.WHITE
		if (tile4 != null):
			tile4.modulate = Color.WHITE
		
		# change int variables according to tiles types and rotation (set to -1 if unsupported), inv circle and small inv circle at the end
		
		if (tile1 == null):
			top_left_shape = -1
		else:
			if (tile1.shape_rotation == Tile.ShapeRotation.TOP_LEFT):
				top_left_shape = tile1.shape_type
			else:
				if (tile1.shape_rotation == Tile.ShapeRotation.BOTTOM_RIGHT):
					if (tile1.shape_type == Game.Shape.CIRCLE):
						top_left_shape = 46
					elif (tile1.shape_type == Game.Shape.SMALL_CIRCLE):
						top_left_shape = 47
					elif (tile1.shape_type == Game.Shape.DIAMOND || tile1.shape_type == Game.Shape.SMALL_DIAMOND):
						top_left_shape = tile1.shape_type
					else:
						top_left_shape = -1
						tile1.modulate = Color(1.0, 0.5, 0.5, 1.0)
				else:
					top_left_shape = -1
					tile1.modulate = Color(1.0, 0.5, 0.5, 1.0)
		
		if (tile2 == null):
			top_right_shape = -1
		else:
			if (tile2.shape_rotation == Tile.ShapeRotation.TOP_RIGHT):
				top_right_shape = tile2.shape_type
			else:
				if (tile2.shape_rotation == Tile.ShapeRotation.BOTTOM_LEFT):
					if (tile2.shape_type == Game.Shape.CIRCLE):
						top_right_shape = 46
					elif (tile2.shape_type == Game.Shape.SMALL_CIRCLE):
						top_right_shape = 47
					elif (tile2.shape_type == Game.Shape.DIAMOND || tile2.shape_type == Game.Shape.SMALL_DIAMOND):
						top_right_shape = tile2.shape_type
					else:
						top_right_shape = -1
						tile2.modulate = Color(1.0, 0.5, 0.5, 1.0)
				else:
					top_right_shape = -1
					tile2.modulate = Color(1.0, 0.5, 0.5, 1.0)
		
		if (tile3 == null):
			bottom_right_shape = -1
		else:
			if (tile3.shape_rotation == Tile.ShapeRotation.BOTTOM_RIGHT):
				bottom_right_shape = tile3.shape_type
			else:
				if (tile3.shape_rotation == Tile.ShapeRotation.TOP_LEFT):
					if (tile3.shape_type == Game.Shape.CIRCLE):
						bottom_right_shape = 46
					elif (tile3.shape_type == Game.Shape.SMALL_CIRCLE):
						bottom_right_shape = 47
					elif (tile3.shape_type == Game.Shape.DIAMOND || tile3.shape_type == Game.Shape.SMALL_DIAMOND):
						bottom_right_shape = tile3.shape_type
					else:
						bottom_right_shape = -1
						tile3.modulate = Color(1.0, 0.5, 0.5, 1.0)
				else:
					bottom_right_shape = -1
					tile3.modulate = Color(1.0, 0.5, 0.5, 1.0)
		
		if (tile4 == null):
			bottom_left_shape = -1
		else:
			if (tile4.shape_rotation == Tile.ShapeRotation.BOTTOM_LEFT):
				bottom_left_shape = tile4.shape_type
			else:
				if (tile4.shape_rotation == Tile.ShapeRotation.TOP_RIGHT):
					if (tile4.shape_type == Game.Shape.CIRCLE):
						bottom_left_shape = 46
					elif (tile4.shape_type == Game.Shape.SMALL_CIRCLE):
						bottom_left_shape = 47
					elif (tile4.shape_type == Game.Shape.DIAMOND || tile4.shape_type == Game.Shape.SMALL_DIAMOND):
						bottom_left_shape = tile4.shape_type
					else:
						bottom_left_shape = -1
						tile4.modulate = Color(1.0, 0.5, 0.5, 1.0)
				else:
					bottom_left_shape = -1
					tile4.modulate = Color(1.0, 0.5, 0.5, 1.0)
		


func update_lines() -> void:
	if (!is_shape_line_finished):
		shape_line2D.add_point(shape_circle.position)
		
	cord_line2D.set_point_position(1, shape_circle.position)
	
	if (is_first_waveform):
		waveform_1_line2D_1.add_point(waveform_1_circle.position)
		waveform_2_line2D_1.add_point(waveform_2_circle.position)
	else:
		waveform_1_line2D_2.add_point(waveform_1_circle.position)
		waveform_2_line2D_2.add_point(waveform_2_circle.position)
	
	link_line2D_1.set_point_position(0, shape_circle.position)
	link_line2D_1.set_point_position(1, waveform_1_circle.position)
	link_line2D_2.set_point_position(0, shape_circle.position)
	link_line2D_2.set_point_position(1, waveform_2_circle.position)
	
	#waveform_1_line2D_1.gradient.set_offset(0, 0.5)
	
	if (debug_mode):
		waveform_1_line2D_1.gradient.set_offset(0, 0.0)
		waveform_2_line2D_1.gradient.set_offset(0, 0.0)
		waveform_1_line2D_1.gradient.set_offset(1, 0.0)
		waveform_2_line2D_1.gradient.set_offset(1, 0.0)
		
		waveform_1_line2D_2.gradient.set_offset(0, 0.0)
		waveform_2_line2D_2.gradient.set_offset(0, 0.0)
		waveform_1_line2D_2.gradient.set_offset(1, 0.0)
		waveform_2_line2D_2.gradient.set_offset(1, 0.0)
		
		waveform_2_line2D_1.gradient.set_color(1, Color.WHITE)
		waveform_2_line2D_2.gradient.set_color(1, Color.WHITE)
	else:
		if (is_first_waveform):
			waveform_1_line2D_1.gradient.set_offset(0, 0.0)
			waveform_2_line2D_1.gradient.set_offset(0, 0.0)
			waveform_1_line2D_1.gradient.set_offset(1, 0.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_1.gradient.set_offset(1, 0.0 + (angle / (PI * 2.0)))
			
			waveform_1_line2D_2.gradient.set_offset(0, 0.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_2.gradient.set_offset(0, 0.0 + (angle / (PI * 2.0)))
			waveform_1_line2D_2.gradient.set_offset(1, 1.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_2.gradient.set_offset(1, 1.0 + (angle / (PI * 2.0)))
		else:
			waveform_1_line2D_2.gradient.set_offset(0, 0.0)
			waveform_2_line2D_2.gradient.set_offset(0, 0.0)
			waveform_1_line2D_2.gradient.set_offset(1, 0.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_2.gradient.set_offset(1, 0.0 + (angle / (PI * 2.0)))
			
			waveform_1_line2D_1.gradient.set_offset(0, 0.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_1.gradient.set_offset(0, 0.0 + (angle / (PI * 2.0)))
			waveform_1_line2D_1.gradient.set_offset(1, 1.0 + (angle / (PI * 2.0)))
			waveform_2_line2D_1.gradient.set_offset(1, 1.0 + (angle / (PI * 2.0)))
	


func find_outside_position(_angle: float, _type: int) -> Vector2:
	if (_type == 0):
		return get_circle_op(_angle)
	elif (_type == 1):
		return get_square_op(_angle)
	elif (_type == 2):
		return get_diamond_op(_angle)
	elif (_type == 3):
		return get_rectangle_op(_angle)
	elif (_type == 4):
		return get_rectanglef_op(_angle)
	elif (_type == 5):
		return get_circle_op(_angle) * 0.5
	elif (_type == 6):
		return get_square_op(_angle) * 0.5
	elif (_type == 7):
		return get_diamond_op(_angle) * 0.5
	elif (_type == 8):
		return get_rectangle_op(_angle) * 0.5
	elif (_type == 9):
		return get_rectanglef_op(_angle) * 0.5
	elif (_type == 10): # circle + rectangle
		var v1 = get_circle_op(_angle)
		var v2 = get_rectangle_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 11): # circle + rectangle f
		var v1 = get_circle_op(_angle)
		var v2 = get_rectanglef_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 12): # diamond + rectangle
		var v1 = get_diamond_op(_angle)
		var v2 = get_rectangle_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 13): # diamond + rectangle f
		var v1 = get_diamond_op(_angle)
		var v2 = get_rectanglef_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 14): # rectangle + rectangle f
		var v1 = get_rectangle_op(_angle)
		var v2 = get_rectanglef_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 15): # rectangle + inv circle
		var v1 = get_rectangle_op(_angle)
		var v2 = get_invcircle_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 16): # rectangle f + inv circle
		var v1 = get_rectanglef_op(_angle)
		var v2 = get_invcircle_op(_angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 17): # inv circle + small circle
		var v1 = get_invcircle_op(_angle)
		var v2 = get_circle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 18): # inv circle + small square
		var v1 = get_invcircle_op(_angle)
		var v2 = get_square_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 19): # inv circle + small rectangle
		var v1 = get_invcircle_op(_angle)
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 20): # inv circle + small rectangle f
		var v1 = get_invcircle_op(_angle)
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 21): # small circle + small rectangle
		var v1 = get_circle_op(_angle) * 0.5
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 22): # small circle + small rectangle f
		var v1 = get_circle_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 23): # small diamond + small rectangle
		var v1 = get_diamond_op(_angle) * 0.5
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 24): # small diamond + small rectangle f
		var v1 = get_diamond_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 25): # small rectangle + small rectangle f
		var v1 = get_rectangle_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 26): # small rectangle + small inv circle
		var v1 = get_rectangle_op(_angle) * 0.5
		var v2 = get_invcircle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 27): # small rectangle f + small inv circle
		var v1 = get_rectanglef_op(_angle) * 0.5
		var v2 = get_invcircle_op(_angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 28): # circle - rectangle
		var v1 = get_circle_op(_angle)
		var v2 = get_rectangle_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 29): # circle - rectangle f
		var v1 = get_circle_op(_angle)
		var v2 = get_rectanglef_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 30): # diamond - rectangle
		var v1 = get_diamond_op(_angle)
		var v2 = get_rectangle_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 31): # diamond - rectangle f
		var v1 = get_diamond_op(_angle)
		var v2 = get_rectanglef_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 32): # rectangle - inv circle
		var v1 = get_rectangle_op(_angle)
		var v2 = get_invcircle_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 33): # rectangle f - inv circle
		var v1 = get_rectanglef_op(_angle)
		var v2 = get_invcircle_op(_angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 34): # inv circle - small circle
		var v1 = get_invcircle_op(_angle)
		var v2 = get_circle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 35): # inv circle - small square
		var v1 = get_invcircle_op(_angle)
		var v2 = get_square_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 36): # inv circle - small rectangle
		var v1 = get_invcircle_op(_angle)
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 37): # inv circle - small rectangle f
		var v1 = get_invcircle_op(_angle)
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 38): # small circle - small rectangle
		var v1 = get_circle_op(_angle) * 0.5
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 39): # small circle - small rectangle f
		var v1 = get_circle_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 40): # small diamond - small rectangle
		var v1 = get_diamond_op(_angle) * 0.5
		var v2 = get_rectangle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 41): # small diamond - small rectangle f
		var v1 = get_diamond_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 42): # small rectangle - small rectangle f
		var v1 = get_rectangle_op(_angle) * 0.5
		var v2 = get_rectanglef_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 43): # small rectangle - small inv circle
		var v1 = get_rectangle_op(_angle) * 0.5
		var v2 = get_invcircle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 44): # small rectangle f - small inv circle
		var v1 = get_rectanglef_op(_angle) * 0.5
		var v2 = get_invcircle_op(_angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (_type == 46):
		return get_invcircle_op(_angle)
	elif (_type == 47):
		return get_invcircle_op(_angle) * 0.5
	else:
		return Vector2.ZERO

func get_circle_op(_angle: float) ->  Vector2:
	return Vector2(-radius, 0).rotated(_angle)

func get_square_op(_angle: float) -> Vector2:
	if (_angle >= PI / 4.0 && _angle <= 3.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(-radius, -radius), Vector2(radius, -radius))
	elif (_angle > 3.0 * (PI / 4.0) && _angle <= 5.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(radius, -radius), Vector2(radius, radius))
	elif (_angle > 5.0 * (PI / 4.0) && _angle <= 7.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(radius, radius), Vector2(-radius, radius))
	else:
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(-radius, radius), Vector2(-radius, -radius))

func get_diamond_op(_angle: float) -> Vector2:
	if (_angle >= 0.0 && _angle <= PI / 2.0):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(-radius, 0.0), Vector2(0.0, -radius))
	elif (_angle > PI / 2.0 && _angle <= PI):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(0.0, -radius), Vector2(radius, 0.0))
	elif (_angle > PI && _angle <= 3 * (PI / 2.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(radius, 0.0), Vector2(0.0, radius))
	else:
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle) * 2.0, Vector2(0.0, radius), Vector2(-radius, 0.0))

func get_invcircle_op(_angle: float) -> Vector2:
	if (_angle >= 0.0 && _angle <= PI / 2.0):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle), Vector2(-radius, -radius), radius)
		return Vector2(-radius, 0.0).rotated(_angle) * intersection_value
	elif (_angle > PI / 2.0 && _angle <= PI):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle), Vector2(radius, -radius), radius)
		return Vector2(-radius, 0.0).rotated(_angle) * intersection_value
	elif (_angle > PI && _angle <= 3 * (PI / 2.0)):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle), Vector2(radius, radius), radius)
		return Vector2(-radius, 0.0).rotated(_angle) * intersection_value
	else:
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(_angle), Vector2(-radius, radius), radius)
		return Vector2(-radius, 0.0).rotated(_angle) * intersection_value


func get_horizontal_rectangle_op(_angle: float) -> Vector2:
	var topIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(-radius, -radius * 0.5), Vector2(radius, -radius * 0.5))
	var rightIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(radius, -radius * 0.5), Vector2(radius, radius * 0.5))
	var bottomIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(radius, radius * 0.5), Vector2(-radius, radius * 0.5))
	var leftIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(-radius, radius * 0.5), Vector2(-radius, -radius * 0.5))
	if (topIntersection != null):
		return topIntersection
	elif (rightIntersection != null):
		return rightIntersection
	elif (bottomIntersection != null):
		return bottomIntersection
	else:
		return leftIntersection

func get_vertical_rectangle_op(_angle: float) -> Vector2:
	var topIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(-radius * 0.5, -radius), Vector2(radius * 0.5, -radius))
	var rightIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(radius * 0.5, -radius), Vector2(radius * 0.5, radius))
	var bottomIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(radius * 0.5, radius), Vector2(-radius * 0.5, radius))
	var leftIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(_angle), Vector2(-radius * 0.5, radius), Vector2(-radius * 0.5, -radius))
	if (topIntersection != null):
		return topIntersection
	elif (rightIntersection != null):
		return rightIntersection
	elif (bottomIntersection != null):
		return bottomIntersection
	else:
		return leftIntersection

func get_rectangle_op(_angle: float) -> Vector2:
	if (_angle >= 0.0 && _angle <= PI / 2.0):
		return get_horizontal_rectangle_op(_angle)
	elif (_angle > PI / 2.0 && _angle <= PI):
		return get_vertical_rectangle_op(_angle)
	elif (_angle > PI && _angle <= 3 * (PI / 2.0)):
		return get_horizontal_rectangle_op(_angle)
	else:
		return get_vertical_rectangle_op(_angle)

func get_rectanglef_op(_angle: float) -> Vector2:
	if (_angle >= 0.0 && _angle <= PI / 2.0):
		return get_vertical_rectangle_op(_angle)
	elif (_angle > PI / 2.0 && _angle <= PI):
		return get_horizontal_rectangle_op(_angle)
	elif (_angle > PI && _angle <= 3 * (PI / 2.0)):
		return get_vertical_rectangle_op(_angle)
	else:
		return get_horizontal_rectangle_op(_angle)
