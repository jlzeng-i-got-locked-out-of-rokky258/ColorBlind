extends Node2D

var FLIP_TIME = 0.5
var flip_counter = 0
onready var yStart = position.y

export var value = 1

var collected = false

func _process(delta):
	flip_counter += delta
	if flip_counter > FLIP_TIME:
		$Sprite.flip_h = !$Sprite.flip_h
		flip_counter = 0
	if collected:
		position.y -= 10 * delta
		if position.y > (yStart + 5):
			queue_free()
		modulate.a -= delta * 2
	else:
		position.y = yStart + (sin(Global.time * 3) * 2) 


func _on_Area2D_body_entered(body):
	Global.collectCoin(value)
	FLIP_TIME = 0.15
	collected = true
	$SFX.play()
