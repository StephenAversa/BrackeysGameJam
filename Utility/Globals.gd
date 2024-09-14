extends Node

var gear_count = 0

var gear_count_for_body = 5
var gear_count_for_legs = 10
var gear_count_for_arms = 15

var conveyor_speed = -100

var player_health = 1


func roll(chance: float):
	var random_value = randf()
	if random_value < chance:
		return true
	else:
		return false
