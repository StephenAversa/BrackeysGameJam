extends Camera2D

var scroll_speed: float = 50.0  # Speed in pixels per second
var scroll_direction: Vector2 = Vector2(0, -1) 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	# Move the camera's position based on the scroll speed and direction
	position += scroll_direction * scroll_speed * delta
