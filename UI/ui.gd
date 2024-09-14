extends Control

@onready var gearcount: Label = $HBoxContainer/VBoxContainer/Gearcount
@onready var tick: TextureRect = $HBoxContainer/VBoxContainer/HBoxContainer/TickBox/Tick
@onready var tick_box: HBoxContainer = $HBoxContainer/VBoxContainer/HBoxContainer/TickBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("update_gear_count",update_gear_count)
	SignalManager.connect("add_health",add_health)

func update_gear_count():
	gearcount.text = "GEARS: " + str(Globals.gear_count)

func add_health():
	var tick_instance = tick.duplicate(true)
	tick_box.add_child(tick_instance)
