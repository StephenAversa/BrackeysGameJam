extends Node2D
@onready var spawn_timer: Timer = $SpawnTimer
var can_spawn = true

var blocks = []

func _ready() -> void:
	blocks = get_block_scenes()
	
func _on_spawn_timer_timeout() -> void:
	if can_spawn:
		var next_block = get_random_element()
		create_block(next_block)
		spawn_timer.start(7)

func create_block(block_scene):
	var block_scene_instance = block_scene.instantiate()
	var tile_map : TileMapLayer = block_scene_instance.get_node("TileMap")
	var tile_size = tile_map.get_used_rect()
	var tile_height_in_pixels = tile_size.size.y * 32
	block_scene_instance.position = Vector2(0,-tile_height_in_pixels)
	add_child(block_scene_instance)


func get_random_element():
	var random_index = randi() % blocks.size()
	return blocks[random_index]

func get_block_scenes():
	var blocks = []
	var dir = DirAccess.open("res://BlockPatterns")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name.contains(".tscn"):
			blocks.append(load("res://BlockPatterns/" + file_name))
			file_name = dir.get_next()
	return blocks
