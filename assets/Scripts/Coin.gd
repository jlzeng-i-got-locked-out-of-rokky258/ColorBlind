extends Node2D

var FLIP_TIME = 0.5
var flip_counter = 0
onready var yStart = position.y

func _process(delta):
	flip_counter += delta
	position.y = yStart + (sin(Global.time * 3) * 2) 
	if flip_counter > FLIP_TIME:
		$Sprite.flip_h = !$Sprite.flip_h
		flip_counter = 0