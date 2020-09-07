extends Node2D

var FLIP_TIME = 0.15
var flip_counter = 0

var newScale = 1.0


func _process(delta):
	flip_counter += delta
	if flip_counter > FLIP_TIME:
		$Sprite.flip_h = !$Sprite.flip_h
		flip_counter = 0
		newScale = Global.rng.randf_range(0.33, 1.0)
	$Light2D.texture_scale = lerp($Light2D.texture_scale, newScale, delta * 10)


func _on_Area2D_body_entered(body):
	if not Global.timerPaused:
		$Label.text = Global.getTimeString()
	Global.player.lastSafePosition = position
