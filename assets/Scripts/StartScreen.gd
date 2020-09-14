extends Control

var path = ""


func _ready():
	pass


func _on_StartButton_pressed():
	path = "res://assets/Scenes/World.tscn"
	$Fade.show()
	$Fade.fade_in()


func _on_OptionsButton_pressed():
	path = "res://assets/Scenes/Options.tscn"
	$Fade.show()
	$Fade.fade_in()


func _on_QuitButton_pressed():
	get_tree().quit()


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_accept"):
		path = "res://assets/Scenes/World.tscn"
		$Fade.show()
		$Fade.fade_in()


func _on_Fade_fade_finished():
	get_tree().change_scene(path)
