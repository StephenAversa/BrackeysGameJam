extends Node2D

const PLATFORM_2 = preload("res://World/platform_2.tscn")
const PLATFORM_1 = preload("res://World/platform_1.tscn")
const arena_width = 800
@onready var spawn_timer: Timer = $SpawnTimer
const FALLING_BOX = preload("res://World/Hazards/falling_box.tscn")
@onready var box_timer: Timer = $BoxTimer
@onready var difficulty_timer: Timer = $DifficultyTimer
var difficulty = 1
var first_fall = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	box_timer.start(randf_range(10,15))
	difficulty_timer.start(Globals.up_the_dif_time)
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


func _on_box_timer_timeout() -> void:
	first_fall = false
	var ui = get_parent().get_node("Camera").get_node("CanvasGroup")
	var rand_x = 200 + randi_range(0,760)
	var falling_instance = FALLING_BOX.instantiate()
	falling_instance.global_position = Vector2(rand_x,0)
	ui.add_child(falling_instance)
	box_timer.start(randf_range(3.0/difficulty,5.0/difficulty))


func _on_difficulty_timer_timeout() -> void:
	if !first_fall:
		difficulty += 1.25
