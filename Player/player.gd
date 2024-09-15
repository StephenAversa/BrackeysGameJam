extends CharacterBody2D
class_name Player

var build_step = 0
const EXPLOSION = preload("res://Utility/explosion.tscn")

@export var head_speed = 200
@export var headbody_speed = 250
@export var headbodylegs_speed = 300
@export var headbodylegsarms_speed = 350
@export var head_jump_speed = 450
@export var headbody_jump_speed = 500
@export var headbodylegs_jump_speed = 600
@export var headbodylegsarms_jump_speed = 600

var move_speed = head_speed
var jump_speed = head_jump_speed

#@export var wall_jump_speed = 400
@export var gravity = 2000
@export var friction = 20
@export var air_friction = 5
@export var wall_friction = 10
var player_direction = 1
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_area: CollisionShape2D = $PlayerArea/CollisionShape2D

#JumpBuffer Timer
@export var canJumpBuffer = false
@export var jumpBufferTime = .1
@onready var jump_buffer_timer = $JumpBufferTimer

var has_double_jump = false
var can_double_jump = false

#CoyoteTimer
@export var canCoyote = false
@export var coyoteTime = .1
@onready var coyote_timer = $CoyoteTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var on_conveyor = false
var conveyor_velocity = 0
@onready var conveyor_check: RayCast2D = $ConveyorCheck
@onready var move_right_check: RayCast2D = $MoveRightCheck
var cant_move_right = false
@onready var jetpack: CPUParticles2D = $Jetpack
@onready var level_up: Node2D = $LevelUp

var is_hurt = false


func _ready() -> void:
	SignalManager.connect("kill_player",death)
	velocity = Vector2.ZERO
	#pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if conveyor_check.is_colliding():
		var collider = conveyor_check.get_collider()
		if collider.is_in_group("conveyor"):
			on_conveyor = true
			conveyor_velocity = Globals.conveyor_speed
	else:
		on_conveyor = false
		conveyor_velocity = 0
	
	if move_right_check.is_colliding():
		var collider = move_right_check.get_collider()
		if collider && collider.is_in_group("box"):
			cant_move_right = true
	else:
		cant_move_right = false

func get_input_direction() -> float:
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction < 0:
		sprite_2d.flip_h = true
		player_direction = -1
	if direction > 0:
		sprite_2d.flip_h = false
		player_direction = 1
	return direction

func get_player_velocity_y() -> int:
	return velocity.y

func _on_coyote_timer_timeout():
	canCoyote = false

func _on_jump_buffer_timer_timeout():
	canJumpBuffer = false

func build_robot(step: int) -> void:
	if step == 1:
		build_command("res://Art/Robot/HeadBody.png")
	if step == 2:
		build_command("res://Art/Robot/HeadBodyLegs.png")
	if step == 3:
		has_double_jump = true
		build_command("res://Art/Robot/HeadBodyLegsBackPack.png")

func get_new_collision(texture: Texture, new_width: int, area: CollisionShape2D) -> RectangleShape2D:
	var texture_size = texture.get_size()
	var rectangle_shape = area.shape as RectangleShape2D
	var new_extents_x = new_width
	var new_extents_y = texture_size.y / 2.0
	rectangle_shape.extents.x = new_extents_x
	rectangle_shape.extents.y = new_extents_y
	return rectangle_shape

func check_upgrade():
	if build_step == 0 && Globals.gear_count >= Globals.gear_count_for_body:
		build_step += 1
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		build_robot(build_step)
		level_up.level_up("Speed Up\nJump Up")
	if build_step == 1 && Globals.gear_count >= Globals.gear_count_for_legs:
		build_step += 1
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		build_robot(build_step)
		level_up.level_up("Speed Up\nJump Up")
	if build_step == 2 && Globals.gear_count >= Globals.gear_count_for_arms:
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		build_step += 1
		build_robot(build_step)
		level_up.level_up("Double Jump")
	if Globals.gear_count >= Globals.gear_count_health3:
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		level_up.level_up("Health Up")
	elif Globals.gear_count >= Globals.gear_count_health2:
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		level_up.level_up("Health Up")
	elif Globals.gear_count >= Globals.gear_count_health1:
		Globals.player_health += 1
		SignalManager.emit_signal("add_health")
		level_up.level_up("Health Up")

func build_command(img: String) -> void:
	sprite_2d.texture = load(img)
	var rectangle_shape = $CollisionShape2D.shape as RectangleShape2D
	rectangle_shape = get_new_collision(sprite_2d.texture, 12, $CollisionShape2D)
	rectangle_shape = player_area.shape as RectangleShape2D
	rectangle_shape = get_new_collision(sprite_2d.texture, 14, player_area)
	move_speed = headbodylegsarms_speed
	jump_speed = headbodylegsarms_jump_speed
	animation_player.play("RESET")


func _on_player_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("gear"):
		Globals.gear_count += 1
		SignalManager.emit_signal("update_gear_count")
		area.get_parent().queue_free()
		SoundManager.get_gear.play()
		check_upgrade()
	if area.is_in_group("hurt"):
		if !is_hurt:
			is_hurt = true
			take_damage()
			SignalManager.emit_signal("remove_health")
	if area.is_in_group("outside"):
		outside()

func take_damage():
	SoundManager.take_damage.play()
	var tween = create_tween()
	for i in 4:
		tween.tween_property(sprite_2d,"modulate",Color(1, 1, 1, 1),.25).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(sprite_2d,"modulate",Color(1, 1, 1, .2),.25).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(sprite_2d,"modulate",Color(1, 1, 1, 1),.25).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	is_hurt = false

func outside():
	if Globals.gear_count > 0:
		Globals.gear_count -= 1
		SignalManager.emit_signal("update_gear_count")
	global_position = Vector2(576, -64)

func death():
	var explosion_instance = EXPLOSION.instantiate()
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	SoundManager.explosion.play()
	SignalManager.emit_signal("game_over")
	queue_free()
		
