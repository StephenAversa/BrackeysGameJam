extends Node

@onready var phase_1_timer: Timer = $Phase1Timer
@onready var total_time = 150.0
var elapsed_time = 0.0
@onready var progress: HBoxContainer = $UI/Progress
var progress_bar: ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar = progress.get_child(0)
	SoundManager.calm_song.play()
	phase_1_timer.start(1)
	
	progress_bar.max_value = total_time
	progress_bar.value = 0

func _on_phase_1_timer_timeout() -> void:
	if elapsed_time < total_time:
		elapsed_time+= 1
		progress_bar.value = elapsed_time
	else:
		phase_1_timer.stop()
		SoundManager.calm_song.stop()
		SceneManager.change_scene("res://Menus/cutscene.tscn")
