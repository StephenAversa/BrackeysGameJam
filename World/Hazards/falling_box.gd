extends Node2D

const BOX_HAZARD = preload("res://World/Hazards/box_hazard.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var camera = get_viewport().get_camera_2d()
	var box_instance = BOX_HAZARD.instantiate()
	box_instance.global_position = Vector2(position.x+48,camera.position.y-384)
	get_parent().get_parent().get_parent().get_node("Phase2Spawner").add_child(box_instance)
	queue_free()
