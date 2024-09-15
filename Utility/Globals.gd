extends Node

var gear_count = 0

var gear_count_for_body = 2
var gear_count_for_legs = 4
var gear_count_for_arms = 6
var gear_count_health1 = 8
var gear_count_health2 = 10
var gear_count_health3 = 12

var conveyor_speed = -100
var up_the_dif_time = 10

var player_health = 5


func roll(chance: float):
	var random_value = randf()
	if random_value < chance:
		return true
	else:
		return false
