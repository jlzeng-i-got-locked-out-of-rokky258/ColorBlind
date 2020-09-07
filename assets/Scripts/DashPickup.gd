extends Node2D

onready var yStart = position.y
var collected = false
signal collected

func _ready():
	$Sprite.modulate = Color(0.65009, 0.882031, 0.8037);


func _process(delta):
	if collected:
		position.y -= 10 * delta
		if position.y > (yStart + 5):
			queue_free()
		modulate.a -= delta * 2
	else:
		position.y = yStart + (sin(Global.time * 3) * 2) 


func _on_Area2D_body_entered(body):
	if not collected:
		Global.player.canDash = true
		emit_signal("collected")
		collected = true
