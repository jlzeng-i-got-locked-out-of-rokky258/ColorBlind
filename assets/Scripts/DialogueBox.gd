extends Control

var dialog = [
	'Huh? Where am I? Underground or something? I need to get back home!',
	'Why is it so COLORLESS around here?',
	'Something is wrong, I should hurry.'
]
var dialog_index = 0;
var finished = false;

func _ready():
	load_dialog()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()


func load_dialog():
	if (dialog_index < dialog.size()):
		$RichTextLabel.bbcode_text = dialog[dialog_index].to_upper()
	else:
		finished = true
		visible = false
	dialog_index += 1
