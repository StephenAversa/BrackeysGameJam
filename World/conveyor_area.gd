extends Area2D

@export var conveyor_speed = -100 # Adjust the speed as needed
@export var direction = Vector2(-1, 0) # Conveyor moves right

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("convey"):
		#body.on_conveyor_entered(conveyor_speed)
#
#
#func _on_body_exited(body: Node2D) -> void:
	#if body.is_in_group("convey"):
		#body.on_conveyor_exited()
