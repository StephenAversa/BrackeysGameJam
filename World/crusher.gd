extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var crush_timer: Timer = $CrushTimer
@onready var smash_particles: CPUParticles2D = $SmashParticles


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("Release")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_crush_timer_timeout() -> void:
	animation_player.play("Crush")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Crush":
		smash_particles.emitting = true
		await get_tree().create_timer(1).timeout
		animation_player.play("Release")
		crush_timer.start(1.9)

func shake():
	SignalManager.emit_signal("screen_shake",.5,10)


func _on_crush_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("platform"):
		body.destroy()


func _on_crush_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("platform"):
		body.destroy()
