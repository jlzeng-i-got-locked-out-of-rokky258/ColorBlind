extends Node

var player 
var time = 0
var deaths = 0
var score = 0

var paused = false
var timerPaused = false


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()


func _process(delta):
	if not paused and not timerPaused:
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


func getTimeString():
	var t = time * 1000
	var minutes = int(t / 60 / 1000)
	var seconds = int(t / 1000) % 60
	var miliseconds = int(t) % 1000
	
	return ("%02d" % minutes) + (":%02d" % seconds) + (":%03d" % miliseconds)
