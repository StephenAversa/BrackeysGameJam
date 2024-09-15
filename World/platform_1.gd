extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var destroyed = false

@onready var spike1: Node2D = $Sprite2D/Spike
@onready var spike2: Node2D = $Sprite2D2/Spike


var smash_dis = 100
var upward_dist = 50
var fall_dist = 400
var smash_dur = .3
var fall_dur = 1
var rotation_angle = randi_range(1,10)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	smash_dis = randi_range(100,150)
	upward_dist = randi_range(50,75)
	if Globals.roll(.8):
		spike1.queue_free()
	if Globals.roll(.8):
		spike2.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func destroy():
	collision_shape_2d.set_deferred("disabled",true)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(sprite_2d,"position",sprite_2d.position + Vector2(-smash_dis,-upward_dist),smash_dur).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite_2d,"rotation",sprite_2d.rotation -rotation_angle,smash_dur).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite_2d_2,"position",sprite_2d_2.position + Vector2(smash_dis,-upward_dist),smash_dur).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite_2d_2,"rotation",sprite_2d_2.rotation + rotation_angle,smash_dur).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	var fall_tween = create_tween().set_parallel(true)
	fall_tween.tween_property(sprite_2d,"position",sprite_2d.position + Vector2(-smash_dis*5,fall_dist),fall_dur).set_ease(Tween.EASE_IN_OUT)
	fall_tween.tween_property(sprite_2d_2,"position",sprite_2d.position + Vector2(smash_dis*5,fall_dist),fall_dur).set_ease(Tween.EASE_IN_OUT)
	fall_tween.tween_property(sprite_2d,"rotation",sprite_2d.rotation -rotation_angle,fall_dur).set_ease(Tween.EASE_IN_OUT)
	fall_tween.tween_property(sprite_2d_2,"rotation",sprite_2d_2.rotation + rotation_angle,fall_dur).set_ease(Tween.EASE_IN_OUT)
