extends Camera2D

var scroll_speed: float = 50.0  # Speed in pixels per second
var scroll_direction: Vector2 = Vector2(0, -1) 

var shake_amount: float
var default_offset : Vector2 = offset
var pos_x : int
var pos_y : int

@onready var timer: Timer = $Timer
@onready var tween : Tween = create_tween()
var can_shake = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("screen_shake",shake)
	randomize()

func _process(delta):
	position += scroll_direction * scroll_speed * delta
	if can_shake:
		offset = Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1,1) * shake_amount)
		
func shake(time: float,amount: float):
	timer.wait_time = time
	shake_amount = amount
	can_shake = true
	timer.start()

func _on_timer_timeout():
	can_shake = false
	tween.interpolate_value(self, "offset",1,1,Tween.TRANS_LINEAR,Tween.EASE_IN)
