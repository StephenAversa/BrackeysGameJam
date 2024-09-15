extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var rot = randf_range(.1,.3)
var gravity = 1000
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.rotation += rot
	global_position.y += gravity * delta


func _on_destroy_timer_timeout() -> void:
	queue_free()
