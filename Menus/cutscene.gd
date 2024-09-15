extends Node
@onready var alarm: ColorRect = $Alarm


func cutscene_over():
	SceneManager.change_scene("res://World/phase_2.tscn")
	SoundManager.rejected.stop()

func rejected():
	SoundManager.rejected.play()
	var tween = create_tween().set_loops()
	tween.tween_property(alarm,"modulate",Color(1, 1, 1, .4),.75).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(alarm,"modulate",Color(1, 1, 1, 0),.75).set_ease(Tween.EASE_IN_OUT)
