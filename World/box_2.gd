extends CharacterBody2D
var on_conveyor = false
var conveyor_velocity = 0
var gravity = 2000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if is_on_floor():
		velocity.x = Globals.conveyor_speed
	
	move_and_slide()
