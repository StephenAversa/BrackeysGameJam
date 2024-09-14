extends Node2D

const PLATFORM_2 = preload("res://World/platform_2.tscn")
const PLATFORM_1 = preload("res://World/platform_1.tscn")
const arena_width = 800
@onready var spawn_timer: Timer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var camera = get_viewport().get_camera_2d()
	var platform_instance = PLATFORM_1.instantiate()
	var rand_x = 200 + randi_range(0,760)
	var y_pos = camera.position.y-364
	platform_instance.global_position = Vector2(rand_x, y_pos)
	add_child(platform_instance)
	if rand_x < 400:
		var new_rand_x = rand_x + randi_range(400,600)
		add_small_platform(new_rand_x, y_pos)
	if rand_x > 700:
		var new_rand_x = rand_x - randi_range(400,600)
		add_small_platform(new_rand_x, y_pos)
		
	spawn_timer.start(2)

func add_small_platform(x_pos: int, y_pos: int):
	var small_platform_instance = PLATFORM_2.instantiate()
	small_platform_instance.global_position = Vector2(x_pos, y_pos)
	add_child(small_platform_instance)
