extends CanvasLayer


func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		$Background.visible = !$Background.visible
		get_tree().paused = !get_tree().paused
		Global.paused = get_tree().paused
	
	if Global.paused:
		if Input.is_action_just_pressed("restart"):
			get_tree().change_scene("res://assets/Scenes/World.tscn")
			$Background.visible = false
			get_tree().paused = false
			Global.paused = false
