extends CharacterBody2D

@export var gravity = 2000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_on_floor():
		velocity.x = Globals.conveyor_speed * delta
	else:
		velocity.y += gravity * delta
	
	move_and_slide()
