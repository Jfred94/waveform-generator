extends Node2D

@onready var outline = $outline
@onready var center = $"center circle"
@onready var outer = $"outer circle"
@onready var outside = $"outside circle"
@onready var outside_line = $"outside line"
@onready var inside_line = $"inside line"
@onready var visualizer_circle = $"visualizer circle"
@onready var visualizer_line = $"visualizer line"
@onready var connector_line = $"connector line"
@onready var shape_list = $ShapeList
@onready var visualizer_circle2 = $"visualizer circle2"
@onready var visualizer_line2 = $"visualizer line2"
@onready var connector_line2 = $"connector line2"

@export var shape_sprites: Array[Texture2D] = []

var timer: float
var radius = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = 0.0
	shape_list.select(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= 4:
		timer -= 4
		visualizer_line.clear_points()
		visualizer_line2.clear_points()
	
	outside.position = Vector2(-200, 0).rotated(timer * PI)
	outside_line.set_point_position(1, outside.position)
	var angle = timer * PI
	if (angle > 2 * PI):
		angle -= 2 * PI
	outer.position = find_outside_position(angle, shape_list.get_selected_items()[0])
	inside_line.set_point_position(1, outer.position)
	
	visualizer_circle.position = Vector2((2 + timer * 1.5) * radius, outer.position.y)
	visualizer_circle2.position = Vector2(outer.position.x, -(2 + timer * 1.5) * radius)
	visualizer_line.add_point(visualizer_circle.position)
	visualizer_line2.add_point((visualizer_circle2.position))
	connector_line.set_point_position(0, outer.position)
	connector_line2.set_point_position(0, outer.position)
	connector_line.set_point_position(1, visualizer_circle.position)
	connector_line2.set_point_position(1, visualizer_circle2.position)
	
	if (shape_sprites.size() > shape_list.get_selected_items()[0]):
		outline.texture = shape_sprites[shape_list.get_selected_items()[0]]
	else:
		outline.texture = null

 #0 = circle
 #1 = small circle
 #2 = square
 #3 = diamond
 #4 = inverted circle quadrants
 #5 = oval (nevermind)
 #6 = cut circle
 #7 = rectangle
 #8 = rectangle f
 #9 = small square
 #10 = small diamond
 #11 = small rectangle
 #12 = small rectangle f
 #13 = small inv circle
 #
 #14 = circle + rectangle
 #15 = circle + rectangle f
 #16 = diamond + rectangle
 #17 = diamond + rectangle f
 #18 = rectangle + rectangle f
 #19 = rectangle + inv circle
 #20 = rectangle f + inv circle
 #21 = inv circle + small circle
 #22 = inv circle + small square
 #23 = inv circle + small rectangle
 #24 = inv circle + small rectangle f
 #25 = small circle + small rectangle
 #26 = small circle + small rectangle f
 #27 = small diamond + small rectangle
 #28 = small diamond + small rectangle f
 #29 = small rectangle + small rectangle f
 #30 = small rectangle + small inv circle
 #31 = small rectangle f + small inv circle
 #
 #32 = circle - rectangle
 #33 = circle - rectangle f
 #34 = diamond - rectangle
 #35 = diamond - rectangle f
 #36 = rectangle - inv circle
 #37 = rectangle f - inv circle
 #38 = inv circle - small circle
 #39 = inv circle - small square
 #40 = inv circle - small rectangle
 #41 = inv circle - small rectangle f
 #42 = small circle - small rectangle
 #43 = small circle - small rectangle f
 #44 = small diamond - small rectangle
 #45 = small diamond - small rectangle f
 #46 = small rectangle - small rectangle f
 #47 = small rectangle - small inv circle
 #48 = small rectangle f - small inv circle

func find_outside_position(angle: float, shape_type: int) ->  Vector2:
	
	if (shape_type == 0): # circle
		return get_circle_op(angle)
		
	elif (shape_type == 1): # small circle
		return get_circle_op(angle) * 0.5
		
	elif (shape_type == 2): # square
		return get_square_op(angle)
	
	elif (shape_type == 3): # diamond
		return get_diamond_op(angle)
	
	elif (shape_type == 4): # inverted circle quadrants
		return get_invcircle_op(angle)
	
	elif (shape_type == 5): # oval (doesn't work)
		return Vector2.ZERO
	
	elif (shape_type == 6): # cut circle
		var circlePosition = Vector2(-radius, 0).rotated(angle)
		if (circlePosition.y >= -radius * 0.5 && circlePosition.y <= radius * 0.5):
			return circlePosition
		else:
			if (angle >= 0.0 && angle < PI):
				return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(-radius, -radius * 0.5), Vector2(radius, -radius * 0.5))
			else:
				return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(-radius, radius * 0.5), Vector2(radius, radius * 0.5))
	
	elif (shape_type == 7): # rectangle
		return get_rectangle_op(angle)
	
	elif (shape_type == 8): # rectangle f
		return get_rectanglef_op(angle)
	
	elif (shape_type == 9): # small square
		return get_square_op(angle) * 0.5
	
	elif (shape_type == 10): # small diamond
		return get_diamond_op(angle) * 0.5
	
	elif (shape_type == 11): # small rectangle
		return get_rectangle_op(angle) * 0.5
	
	elif (shape_type == 12): # small rectangle f
		return get_rectanglef_op(angle) * 0.5
	
	elif (shape_type == 13): # small inv circle
		return get_invcircle_op(angle) * 0.5
	
	elif (shape_type == 14): # circle + rectangle
		var v1 = get_circle_op(angle)
		var v2 = get_rectangle_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 15): # circle + rectangle f
		var v1 = get_circle_op(angle)
		var v2 = get_rectanglef_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 16): # diamond + rectangle
		var v1 = get_diamond_op(angle)
		var v2 = get_rectangle_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 17): # diamond + rectangle f
		var v1 = get_diamond_op(angle)
		var v2 = get_rectanglef_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 18): # rectangle + rectangle f
		var v1 = get_rectangle_op(angle)
		var v2 = get_rectanglef_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 19): # rectangle + inv circle
		var v1 = get_rectangle_op(angle)
		var v2 = get_invcircle_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 20): # rectangle f + inv circle
		var v1 = get_rectanglef_op(angle)
		var v2 = get_invcircle_op(angle)
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 21): # inv circle + small circle
		var v1 = get_invcircle_op(angle)
		var v2 = get_circle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 22): # inv circle + small square
		var v1 = get_invcircle_op(angle)
		var v2 = get_square_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 23): # inv circle + small rectangle
		var v1 = get_invcircle_op(angle)
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 24): # inv circle + small rectangle f
		var v1 = get_invcircle_op(angle)
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 25): # small circle + small rectangle
		var v1 = get_circle_op(angle) * 0.5
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 26): # small circle + small rectangle f
		var v1 = get_circle_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 27): # small diamond + small rectangle
		var v1 = get_diamond_op(angle) * 0.5
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 28): # small diamond + small rectangle f
		var v1 = get_diamond_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 29): # small rectangle + small rectangle f
		var v1 = get_rectangle_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 30): # small rectangle + small inv circle
		var v1 = get_rectangle_op(angle) * 0.5
		var v2 = get_invcircle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 31): # small rectangle f + small inv circle
		var v1 = get_rectanglef_op(angle) * 0.5
		var v2 = get_invcircle_op(angle) * 0.5
		if (v1.length() > v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 32): # circle - rectangle
		var v1 = get_circle_op(angle)
		var v2 = get_rectangle_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 33): # circle - rectangle f
		var v1 = get_circle_op(angle)
		var v2 = get_rectanglef_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 34): # diamond - rectangle
		var v1 = get_diamond_op(angle)
		var v2 = get_rectangle_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 35): # diamond - rectangle f
		var v1 = get_diamond_op(angle)
		var v2 = get_rectanglef_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 36): # rectangle - inv circle
		var v1 = get_rectangle_op(angle)
		var v2 = get_invcircle_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 37): # rectangle f - inv circle
		var v1 = get_rectanglef_op(angle)
		var v2 = get_invcircle_op(angle)
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 38): # inv circle - small circle
		var v1 = get_invcircle_op(angle)
		var v2 = get_circle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 39): # inv circle - small square
		var v1 = get_invcircle_op(angle)
		var v2 = get_square_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 40): # inv circle - small rectangle
		var v1 = get_invcircle_op(angle)
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 41): # inv circle - small rectangle f
		var v1 = get_invcircle_op(angle)
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 42): # small circle - small rectangle
		var v1 = get_circle_op(angle) * 0.5
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 43): # small circle - small rectangle f
		var v1 = get_circle_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 44): # small diamond - small rectangle
		var v1 = get_diamond_op(angle) * 0.5
		var v2 = get_rectangle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 45): # small diamond - small rectangle f
		var v1 = get_diamond_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 46): # small rectangle - small rectangle f
		var v1 = get_rectangle_op(angle) * 0.5
		var v2 = get_rectanglef_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 47): # small rectangle - small inv circle
		var v1 = get_rectangle_op(angle) * 0.5
		var v2 = get_invcircle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	elif (shape_type == 48): # small rectangle f - small inv circle
		var v1 = get_rectanglef_op(angle) * 0.5
		var v2 = get_invcircle_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return v1
		else:
			return v2
	
	
	else:
		return Vector2.ZERO
	





func get_circle_op(angle: float) ->  Vector2:
	return Vector2(-radius, 0).rotated(angle)

func get_square_op(angle: float) -> Vector2:
	if (angle >= PI / 4.0 && angle <= 3.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, -radius), Vector2(radius, -radius))
	elif (angle > 3.0 * (PI / 4.0) && angle <= 5.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, -radius), Vector2(radius, radius))
	elif (angle > 5.0 * (PI / 4.0) && angle <= 7.0 * (PI / 4.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, radius), Vector2(-radius, radius))
	else:
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, radius), Vector2(-radius, -radius))

func get_diamond_op(angle: float) -> Vector2:
	if (angle >= 0.0 && angle <= PI / 2.0):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, 0.0), Vector2(0.0, -radius))
	elif (angle > PI / 2.0 && angle <= PI):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(0.0, -radius), Vector2(radius, 0.0))
	elif (angle > PI && angle <= 3 * (PI / 2.0)):
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, 0.0), Vector2(0.0, radius))
	else:
		return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(0.0, radius), Vector2(-radius, 0.0))

func get_invcircle_op(angle: float) -> Vector2:
	if (angle >= 0.0 && angle <= PI / 2.0):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(-radius, -radius), radius)
		return Vector2(-radius, 0.0).rotated(angle) * intersection_value
	elif (angle > PI / 2.0 && angle <= PI):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(radius, -radius), radius)
		return Vector2(-radius, 0.0).rotated(angle) * intersection_value
	elif (angle > PI && angle <= 3 * (PI / 2.0)):
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(radius, radius), radius)
		return Vector2(-radius, 0.0).rotated(angle) * intersection_value
	else:
		var intersection_value = Geometry2D.segment_intersects_circle(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle), Vector2(-radius, radius), radius)
		return Vector2(-radius, 0.0).rotated(angle) * intersection_value


func get_horizontal_rectangle_op(angle: float) -> Vector2:
	var topIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(-radius, -radius * 0.5), Vector2(radius, -radius * 0.5))
	var rightIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(radius, -radius * 0.5), Vector2(radius, radius * 0.5))
	var bottomIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(radius, radius * 0.5), Vector2(-radius, radius * 0.5))
	var leftIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(-radius, radius * 0.5), Vector2(-radius, -radius * 0.5))
	if (topIntersection != null):
		return topIntersection
	elif (rightIntersection != null):
		return rightIntersection
	elif (bottomIntersection != null):
		return bottomIntersection
	else:
		return leftIntersection

func get_vertical_rectangle_op(angle: float) -> Vector2:
	var topIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(-radius * 0.5, -radius), Vector2(radius * 0.5, -radius))
	var rightIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(radius * 0.5, -radius), Vector2(radius * 0.5, radius))
	var bottomIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(radius * 0.5, radius), Vector2(-radius * 0.5, radius))
	var leftIntersection = Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius * 2.0, 0.0).rotated(angle), Vector2(-radius * 0.5, radius), Vector2(-radius * 0.5, -radius))
	if (topIntersection != null):
		return topIntersection
	elif (rightIntersection != null):
		return rightIntersection
	elif (bottomIntersection != null):
		return bottomIntersection
	else:
		return leftIntersection

func get_rectangle_op(angle: float) -> Vector2:
	if (angle >= 0.0 && angle <= PI / 2.0):
		return get_horizontal_rectangle_op(angle)
	elif (angle > PI / 2.0 && angle <= PI):
		return get_vertical_rectangle_op(angle)
	elif (angle > PI && angle <= 3 * (PI / 2.0)):
		return get_horizontal_rectangle_op(angle)
	else:
		return get_vertical_rectangle_op(angle)

func get_rectanglef_op(angle: float) -> Vector2:
	if (angle >= 0.0 && angle <= PI / 2.0):
		return get_vertical_rectangle_op(angle)
	elif (angle > PI / 2.0 && angle <= PI):
		return get_horizontal_rectangle_op(angle)
	elif (angle > PI && angle <= 3 * (PI / 2.0)):
		return get_vertical_rectangle_op(angle)
	else:
		return get_horizontal_rectangle_op(angle)
