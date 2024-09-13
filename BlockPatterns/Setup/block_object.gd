extends Node2D
class_name BlockObject

var speed: float = -Globals.conveyor_speed # Default speed for all objects
var direction: Vector2 = Vector2(-1, 0)  # Default direction (to the right)
@export var friction = 20

func _physics_process(delta: float) -> void:
	move_object(delta)

func move_object(delta):
	position += direction * speed * delta
