extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(scene : String):
	animation_player.play("Fade")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play_backwards("Fade")
