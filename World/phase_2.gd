extends Node

@onready var player: Player = $Player
@onready var alarm: ColorRect = $Camera/CanvasGroup/Alarm
@onready var game_over_timer: Timer = $GameOverTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("game_over",game_over)
	player.build_robot(3)
	player.build_step = 3
	SignalManager.emit_signal("set_health", Globals.player_health)
	SoundManager.aggressive_song.play()
	
	var tween = create_tween().set_loops()
	tween.tween_property(alarm,"modulate",Color(1, 1, 1, .3),.75).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(alarm,"modulate",Color(1, 1, 1, 0),.75).set_ease(Tween.EASE_IN_OUT)

func _on_game_over_timer_timeout() -> void:
	SoundManager.aggressive_song.stop()
	SceneManager.change_scene("res://Menus/start_menu.tscn")

func game_over():
	game_over_timer.start(2)
