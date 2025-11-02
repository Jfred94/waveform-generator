extends Node2D

@onready var square = $square
@onready var center = $"center circle"
@onready var outer = $"outer circle"
@onready var outside = $"outside circle"
@onready var outside_line = $"outside line"
@onready var inside_line = $"inside line"
@onready var visualizer_circle = $"visualizer circle"
@onready var visualizer_line = $"visualizer line"
@onready var connector_line = $"connector line"

var timer: float
var radius = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= 4:
		timer -= 4
		visualizer_line.clear_points()
	
	outside.position = Vector2(-200, 0).rotated(timer * PI)
	outside_line.set_point_position(1, outside.position)
	var angle = timer * PI
	if (angle > 2 * PI):
		angle -= 2 * PI
	outer.position = find_outside_position(angle, 2)
	inside_line.set_point_position(1, outer.position)
	
	visualizer_circle.position = Vector2((2 + timer * 1.5) * radius, outer.position.y)
	visualizer_line.add_point(visualizer_circle.position)
	connector_line.set_point_position(0, outer.position)
	connector_line.set_point_position(1, visualizer_circle.position)

# 0 = circle
# 1 = small circle
# 2 = square
func find_outside_position(angle: float, shape_type: int) ->  Vector2:
	
	if (shape_type == 0):
		return Vector2(-radius, 0).rotated(angle)
		
	elif (shape_type == 1):
		return Vector2(-radius * 0.5, 0).rotated(angle)
		
	elif (shape_type == 2):
		if (angle >= 0.0 && angle <= PI / 4.0):
			return Vector2(-radius, -abs(tan(angle)) * radius)
		elif (angle > PI / 4.0 && angle <= PI / 2.0):
			return Vector2(-abs(tan((PI / 2.0) - angle)) * radius, -radius)
		elif (angle > PI / 2.0 && angle <= 3 * (PI / 4.0)):
			return Vector2(abs(tan(angle - (PI / 2.0))) * radius, -radius)
		elif (angle > 3 * (PI / 4.0) && angle <= PI):
			return Vector2(radius, -abs(tan(PI - angle)) * radius)
		elif (angle > PI && angle <= 5 * (PI / 4.0)):
			return Vector2(radius, abs(tan(angle - PI)) * radius)
		elif (angle > 5 * (PI / 4.0) && angle <= 3 * (PI / 2.0)):
			return Vector2(abs(tan((3 * (PI / 2.0)) - angle)) * radius, radius)
		elif (angle > 3 * (PI / 2.0) && angle <= 7 * (PI / 4.0)):
			return Vector2(-abs(tan(angle - (3 * (PI / 2.0)))) * radius, radius)
		else:
			return Vector2(-radius, abs(tan((2 * PI) - angle)) * radius)
			
	else:
		return Vector2.ZERO
