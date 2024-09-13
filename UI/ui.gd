extends Control

@onready var gearcount: Label = $Gearcount

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("update_gear_count",update_gear_count)

func update_gear_count():
	gearcount.text = "GEARS: " + str(Globals.gear_count)
