extends PlayerState

@export var animationPlayer : AnimationPlayer

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		state_machine.transition_to("Air", {jump = true})


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if !player.is_on_floor():
		state_machine.transition_to("Air", {coyote = true})
	elif player.has_double_jump:
		player.can_double_jump = true

	if (!is_zero_approx(player.get_input_direction())):
		if player.player_direction == 1:
			if !player.cant_move_right:
				player.velocity.x = lerp(player.velocity.x,player.get_input_direction() * player.move_speed + player.conveyor_velocity,player.friction * delta)
			else:
				state_machine.transition_to("Idle")
		else:
			player.velocity.x = lerp(player.velocity.x,player.get_input_direction() * player.move_speed + player.conveyor_velocity,player.friction * delta)
	else:
		state_machine.transition_to("Idle")
	
	if player.canJumpBuffer:
		player.canJumpBuffer = false
		state_machine.transition_to("Air", {jump = true})
	
	player.move_and_slide()

func enter(msg := {}) -> void:
	player.canCoyote = true
	if player.build_step == 0:
		if player.player_direction == 1:
			animationPlayer.play("HeadRunRight")
		else:
			animationPlayer.play("HeadRunLeft")
	else:
			animationPlayer.play("HeadBodyRun")

func exit() -> void:
	pass
