extends Node2D

export var power = Vector2(0, -1000.0)


func _on_Area2D_body_entered(body):
	Global.player.velocity = power
