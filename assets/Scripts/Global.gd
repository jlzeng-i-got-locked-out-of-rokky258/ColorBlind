extends Node

var player 

var time = 0

var deaths = 0

func _ready():
	pass


func _process(delta):
	time += delta


func killPlayer():
	player.die()
	deaths += 1

func getDeaths():
	return deaths
