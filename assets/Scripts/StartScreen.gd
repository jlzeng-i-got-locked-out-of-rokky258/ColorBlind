extends Control

var path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _on_StartButton_pressed():
	print_debug("PRESSED")
	path = "res://assets/Scenes/World.tscn"
	$Fade.show()
	$Fade.fade_in()

func _on_OptionsButton_pressed():
	print_debug("PRESSED")
	path = "res://assets/Scenes/World.tscn"

func _on_QuitButton_pressed():
	print_debug("PRESSED")
	get_tree().quit()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_accept"):
		path = "res://assets/Scenes/World.tscn"
		$Fade.show()
		$Fade.fade_in()

func _on_Fade_fade_finished():
	print_debug("changing")
	get_tree().change_scene(path)
