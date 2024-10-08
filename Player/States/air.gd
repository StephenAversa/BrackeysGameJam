extends PlayerState

@export var animationPlayer : AnimationPlayer

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		if !player.coyote_timer.is_stopped():
			player.coyote_timer.stop()
			state_machine.transition_to("Air", {jump = true})
		if !player.canJumpBuffer:
			player.canJumpBuffer = true
			player.jump_buffer_timer.start(.1)
		if player.can_double_jump:
			SoundManager.jet_pack.play()
			player.velocity.y = -player.jump_speed/1.25
			player.jetpack.emitting = true
			player.can_double_jump = false

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	
	if player.is_on_floor():
		state_machine.transition_to("Idle")
	else:
		player.velocity.y += player.gravity * delta
	
	if (!is_zero_approx(player.get_input_direction())):
		if player.player_direction == 1:
			if !player.cant_move_right:
				player.velocity.x = lerp(player.velocity.x,player.get_input_direction() * player.move_speed,player.air_friction * delta)
		else:
			player.velocity.x = lerp(player.velocity.x,player.get_input_direction() * player.move_speed,player.air_friction * delta)
	else:
		player.velocity.x = lerp(player.velocity.x, float(0), player.air_friction * delta)
	
	player.move_and_slide()

func enter(msg := {}) -> void:
	#Add animations for jumps in section below
	#handle_jump_animation()
	if (msg.has("jump")):
		SoundManager.jump.play()
		player.velocity.y = -player.jump_speed
	if msg.has("coyote"):
		player.coyote_timer.start()
	animationPlayer.play("HeadBodyIdle")
		

func exit() -> void:
	pass

func handle_jump_animation() -> void:
	if player.get_player_velocity_y() < 0:
		animationPlayer.play("JumpUp")
	else:
		animationPlayer.play("JumpDown")
