extends Node2D

@onready var label: Label = $Control/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func level_up(msg: String):
	label.text = msg
	animation_player.play("LevelUp")
