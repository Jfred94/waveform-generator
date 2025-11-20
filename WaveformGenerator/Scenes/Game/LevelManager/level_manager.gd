extends Node2D
class_name LevelManager

@export var background: TextureRect

@export var visualizer: Visualizer

@export var pure_background: Texture2D
@export var true_background: Texture2D # with grid

@export var backgrounds: Array[Texture2D]

var level: int = 1
var radius: float
var angle: float

var is_incorrect: bool = false

@export var bars: Node2D
@export var bars2: Node2D
var was_correct: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.texture = backgrounds[1]
	radius = visualizer.radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	angle = visualizer.angle
	if (check_if_correct()):
		
		if (!was_correct):
			var bar: Line2D = Line2D.new()
			bars.add_child(bar)
			bar.width = 500
			bar.add_point(Vector2(240 + angle * (320 / PI), 0))
			bar.add_point(Vector2(240 + angle * (320 / PI), 0))
			bar.modulate = Color(1, 1, 1, 0.5)
			
			var bar2: Line2D = Line2D.new()
			bars2.add_child(bar2)
			bar2.width = 500
			bar2.add_point(Vector2(0, -240 - angle * (320 / PI)))
			bar2.add_point(Vector2(0, -240 - angle * (320 / PI)))
			bar2.modulate = Color(0.541, 0.569, 1.0, 0.5)
		else:
			var bar: Line2D = bars.get_child(-1)
			bar.set_point_position(1, Vector2(240 + angle * (320 / PI), 0))
			var bar2: Line2D = bars2.get_child(-1)
			bar2.set_point_position(1, Vector2(0, -240 - angle * (320 / PI)))
		
		was_correct = true
	else:
		is_incorrect = true
		was_correct = false
	
	
	

func end_of_cycle() -> void:
	if (!is_incorrect):
		next_level()
	is_incorrect = false
	was_correct = false
	for bar in bars.get_children():
		bar.queue_free()
	for bar in bars2.get_children():
		bar.queue_free()
	

func next_level() -> void:
	level += 1
	if (backgrounds.size() > level):
		background.texture = backgrounds[level]
	print("next level: " + str(level))

func check_if_correct() -> bool:
	
	
	if (level == 1): # square
		return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
	
	if (level == 2):
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
	
	elif (level == 3): # inv circle
		return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
	
	elif (level == 4): # big crescent
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
	
	# UNLOCK DIAMOND
	
	elif (level == 5): # fish
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, Vector2.ZERO)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, Vector2.ZERO)
	
	elif (level == 6): # diamond
		return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
	
	elif (level == 7): # hourglass
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
	
	# UNLOCK SHRINK
	
	elif (level == 8): # skullduggery
		if (angle >= 0.0 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle) * 0.5)
	
	elif (level == 9): # rounded bowtie
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle) * 0.5)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle) * 0.5)
	
	elif (level == 10): # circle fiesta
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, Vector2.ZERO)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle) * 0.5)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
	
	elif (level == 11): # square arrow left
		if (angle >= PI * 0.5 && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle) * 0.5)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
	
	elif (level == 12): # japanese symbol for beginner
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle) * 0.5)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, Vector2.ZERO)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle) * 0.5)
	
	# UNLOCK RECTANGLE & FLIP
	
	elif (level == 13): # horizontal rectangle
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle))
	
	elif (level == 14): # small vertical rectangle
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle) * 0.5)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle) * 0.5)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle) * 0.5)
	
	elif (level == 15): # rectangle arrow right
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle))
	
	elif (level == 16): # fibonacci but square
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle) * 0.5)
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle))
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_square_op(angle))
	
	elif (level == 17): # blocky boomerang
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectanglef_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle) * 0.5)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_rectangle_op(angle))
	
	# UNLOCK ADDITIVE COMBINE
	
	elif (level == 18): # shell
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
		elif (angle >= PI * 0.5 && angle < PI):
			var v1 = visualizer.get_rectanglef_op(angle)
			var v2 = visualizer.get_diamond_op(angle)
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		elif (angle >= PI && angle < PI * 1.5):
			var v1 = visualizer.get_rectangle_op(angle)
			var v2 = visualizer.get_diamond_op(angle)
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_circle_op(angle))
	
	elif (level == 19): # cross
		var v1 = visualizer.get_rectangle_op(angle)
		var v2 = visualizer.get_rectanglef_op(angle)
		if (v1.length() > v2.length()):
			return close_enough(visualizer.shape_circle.position, v1)
		else:
			return close_enough(visualizer.shape_circle.position, v2)
	
	elif (level == 20): # cross & small cross alternating
		if (angle >= 0.0 && angle < PI * 0.5):
			var v1 = visualizer.get_rectangle_op(angle)
			var v2 = visualizer.get_rectanglef_op(angle)
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		elif (angle >= PI * 0.5 && angle < PI):
			var v1 = visualizer.get_rectangle_op(angle) * 0.5
			var v2 = visualizer.get_rectanglef_op(angle) * 0.5
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		elif (angle >= PI && angle < PI * 1.5):
			var v1 = visualizer.get_rectangle_op(angle)
			var v2 = visualizer.get_rectanglef_op(angle)
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		else:
			var v1 = visualizer.get_rectangle_op(angle) * 0.5
			var v2 = visualizer.get_rectanglef_op(angle) * 0.5
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
	
	elif (level == 21): # square candy or smth
		if (angle >= 0.0 && angle < PI * 0.5):
			var v1 = visualizer.get_invcircle_op(angle)
			var v2 = visualizer.get_square_op(angle) * 0.5
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
		elif (angle >= PI && angle < PI * 1.5):
			var v1 = visualizer.get_invcircle_op(angle)
			var v2 = visualizer.get_square_op(angle) * 0.5
			if (v1.length() > v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		else:
			return close_enough(visualizer.shape_circle.position, visualizer.get_invcircle_op(angle))
	
	# UNLOCK EXCLUSIVE COMBINE
	
	elif (level == 22): # boat
		if (angle >= 0.0 && angle < PI * 0.5):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle) * 0.5)
		elif (angle >= PI * 0.5 && angle < PI):
			return close_enough(visualizer.shape_circle.position, visualizer.get_diamond_op(angle) * 0.5)
		elif (angle >= PI && angle < PI * 1.5):
			var v1 = visualizer.get_rectangle_op(angle)
			var v2 = visualizer.get_diamond_op(angle)
			if (v1.length() < v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
		else:
			var v1 = visualizer.get_rectanglef_op(angle)
			var v2 = visualizer.get_diamond_op(angle)
			if (v1.length() < v2.length()):
				return close_enough(visualizer.shape_circle.position, v1)
			else:
				return close_enough(visualizer.shape_circle.position, v2)
	
	elif (level == 23): # pinwheel
		var v1 = visualizer.get_rectangle_op(angle)
		var v2 = visualizer.get_diamond_op(angle)
		if (v1.length() < v2.length()):
			return close_enough(visualizer.shape_circle.position, v1)
		else:
			return close_enough(visualizer.shape_circle.position, v2)
	
	elif (level == 24): # teeny tiny square
		var v1 = visualizer.get_rectangle_op(angle) * 0.5
		var v2 = visualizer.get_rectanglef_op(angle) * 0.5
		if (v1.length() < v2.length()):
			return close_enough(visualizer.shape_circle.position, v1)
		else:
			return close_enough(visualizer.shape_circle.position, v2)
	
	elif (level == 25): # straight line
		return close_enough(visualizer.shape_circle.position, Vector2.ZERO)
	
	else:
		return false


var close_to_zero: float = 0.001

func close_enough(v1: Vector2, v2: Vector2) -> bool:
	return (abs(v1.x - v2.x) < close_to_zero && abs(v1.y - v2.y) < close_to_zero && !visualizer.debug_mode)
