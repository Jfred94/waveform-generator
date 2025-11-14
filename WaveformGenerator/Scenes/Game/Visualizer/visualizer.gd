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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle += delta * PI * 0.5
	if (angle >= 2.0 * PI):
		angle -= 2.0 * PI
	
	var shape_index: int
	if (angle >= 0.0 && angle < PI * 0.5):
		shape_index = top_left_shape
	elif (angle >= PI * 0.5 && angle < PI):
		shape_index = top_right_shape
	elif (angle >= PI && angle < PI * 1.5):
		shape_index = bottom_right_shape
	else:
		shape_index = bottom_left_shape
	shape_circle.position = find_outside_position(angle, shape_index)

func update_shapes(_tile1: Tile, _tile2: Tile, _tile3: Tile, _tile4: Tile) -> void:
	
	if (tile1 == _tile1 && tile2 == _tile2 && tile3 == _tile3 && tile4 == _tile4):
		return
	else:
		tile1 = _tile1
		tile2 = _tile2
		tile3 = _tile3
		tile4 = _tile4
		
		if (tile1 != null && tile2 != null && tile3 != null && tile4 != null):
			print("tile 1: type: " + str(tile1.shape_type) + " ; rot: " + str(tile1.shape_rotation))
			print("tile 2: type: " + str(tile2.shape_type) + " ; rot: " + str(tile2.shape_rotation))
			print("tile 3: type: " + str(tile3.shape_type) + " ; rot: " + str(tile3.shape_rotation))
			print("tile 4: type: " + str(tile4.shape_type) + " ; rot: " + str(tile4.shape_rotation))
		
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
				else:
					top_left_shape = -1
		
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
				else:
					top_right_shape = -1
		
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
				else:
					bottom_right_shape = -1
		
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
				else:
					bottom_left_shape = -1
		

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
		return get_rectangle_op(_angle) * 0.5
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
