extends Control

@onready var gearcount: Label = $HBoxContainer/VBoxContainer/Gearcount
@onready var tick: TextureRect = $HBoxContainer/VBoxContainer/HBoxContainer/TickBox/Tick
@onready var tick_box: HBoxContainer = $HBoxContainer/VBoxContainer/HBoxContainer/TickBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("update_gear_count",update_gear_count)
	SignalManager.connect("add_health",add_health)
	SignalManager.connect("set_health",set_health)
	SignalManager.connect("remove_health",remove_health)

func update_gear_count():
	gearcount.text = "GEARS: " + str(Globals.gear_count)

func add_health():
	Globals.player_health += 1
	var tick_instance = tick.duplicate(true)
	tick_box.add_child(tick_instance)

func remove_health():
	if Globals.player_health > 1:
		Globals.player_health -= 1
		var tick_instance = tick_box.get_child(tick_box.get_child_count() -1)
		tick_instance.queue_free()
	else:
		SignalManager.emit_signal("kill_player")

func set_health(num: int):
	for i in num-1:
		var tick_instance = tick.duplicate(true)
		tick_box.add_child(tick_instance)
