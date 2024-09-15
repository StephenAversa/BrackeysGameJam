extends Node2D
@onready var debris: CPUParticles2D = $Debris
@onready var dust: CPUParticles2D = $Dust


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dust.emitting = true
	debris.emitting = true
