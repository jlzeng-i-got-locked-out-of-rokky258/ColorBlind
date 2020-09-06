extends Node

var player 

var time = 0

var deaths = 0

var score = 0

func _ready():
	pass


func _process(delta):
	time += delta


func collectCoin(value):
	score += value


func killPlayer():
	player.die()
	deaths += 1


func getDeaths():
	return deaths
