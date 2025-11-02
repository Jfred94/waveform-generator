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
	
	outline.texture = shape_sprites[shape_list.get_selected_items()[0]]

# 0 = circle
# 1 = small circle
# 2 = square
# 3 = diamond
# 4 = inverted circle quadrants
# 5 = oval
# 6 = cut circle
# 7 = rectangle
func find_outside_position(angle: float, shape_type: int) ->  Vector2:
	
	if (shape_type == 0): # circle
		return Vector2(-radius, 0).rotated(angle)
		
	elif (shape_type == 1): # small circle
		return Vector2(-radius * 0.5, 0).rotated(angle)
		
	elif (shape_type == 2): # square
		if (angle >= PI / 4.0 && angle <= 3.0 * (PI / 4.0)):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, -radius), Vector2(radius, -radius))
		elif (angle > 3.0 * (PI / 4.0) && angle <= 5.0 * (PI / 4.0)):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, -radius), Vector2(radius, radius))
		elif (angle > 5.0 * (PI / 4.0) && angle <= 7.0 * (PI / 4.0)):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, radius), Vector2(-radius, radius))
		else:
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, radius), Vector2(-radius, -radius))
	
	elif (shape_type == 3): # diamond
		if (angle >= 0.0 && angle <= PI / 2.0):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(-radius, 0.0), Vector2(0.0, -radius))
		elif (angle > PI / 2.0 && angle <= PI):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(0.0, -radius), Vector2(radius, 0.0))
		elif (angle > PI && angle <= 3 * (PI / 2.0)):
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(radius, 0.0), Vector2(0.0, radius))
		else:
			return Geometry2D.segment_intersects_segment(Vector2.ZERO, Vector2(-radius, 0.0).rotated(angle) * 2.0, Vector2(0.0, radius), Vector2(-radius, 0.0))
	
	elif (shape_type == 4): # inverted circle quadrants
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
	
	elif (shape_type == 5): # oval
		var circlePosition = Vector2(-radius, 0).rotated(angle)
		return Vector2(circlePosition.x, circlePosition.y * 0.5)
	
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
		return Vector2.ZERO
	
	else:
		return Vector2.ZERO
	
