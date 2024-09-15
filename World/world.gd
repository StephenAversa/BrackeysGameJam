extends Node

@onready var phase_1_timer: Timer = $Phase1Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.calm_song.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_phase_1_timer_timeout() -> void:
	SoundManager.calm_song.stop()
	SceneManager.change_scene("res://Menus/cutscene.tscn")
