extends CharacterBody2D
var on_conveyor = false
var conveyor_velocity = 0
var gravity = 500
var can_combine = true
@onready var box_check: RayCast2D = $BoxCheck

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_on_floor():
		velocity.y = 0
		if box_check.is_colliding():
			var test = box_check.get_collider()
			if box_check.get_collider().is_in_group("box"):
				combine_with(box_check.get_collider().get_parent())
		velocity.x = Globals.conveyor_speed * delta
	else:
		velocity.y += gravity * delta

	move_and_slide()

func combine_with(other_box) -> void:
	var relative_position = global_position - Vector2(other_box.global_position.x,other_box.global_position.y-6)
	set_physics_process(false)
	get_parent().remove_child(self)
	other_box.add_child(self)
	position = relative_position
