extends PlayerState

@export var animationPlayer : AnimationPlayer

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		state_machine.transition_to("Air", {jump = true})

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if !player.is_on_floor():
		state_machine.transition_to("Air")
	elif !is_zero_approx(player.get_input_direction()):
		state_machine.transition_to("Run")
	
	if player.canJumpBuffer:
		player.canJumpBuffer = false
		state_machine.transition_to("Air", {jump = true})
	
	player.velocity.x = lerp(player.velocity.x, float(0),player.friction * delta)

func enter(msg := {}) -> void:
	player.canCoyote = true
	if player.build_step == 0:
		animationPlayer.play("HeadIdle")

func exit() -> void:
	pass
