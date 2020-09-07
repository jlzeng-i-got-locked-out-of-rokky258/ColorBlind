extends Node

var player 
var time = 0
var deaths = 0
var score = 0
var sfxVol = 0
var musicVol = 0

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _process(delta):
	time += delta


func collectCoin(value):
	score += value


func killPlayer():
	player.die()
	deaths += 1


func getDeaths():
	return deaths

func getScore():
	return score
