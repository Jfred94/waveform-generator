extends Node2D
class_name ShapeLineGhost

var timer: float
var fade_time: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = fade_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	modulate = Color(1, 1, 1, timer / fade_time)
	if (timer <= 0.0):
		queue_free()
