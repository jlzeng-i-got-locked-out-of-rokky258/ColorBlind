extends Control

var dialog = [
	'Hi there this is cringe',
	'owo uwu'
]
var dialog_index = 0;
var finished = false;

func _ready():
	load_dialog()

func _process(_delta):
	if Input.is_action_just_pressed("move_jump"):
		load_dialog()

func load_dialog():
	if (dialog_index < dialog.size()):
		$RichTextLabel.bbcode_text = dialog[dialog_index]
	else:
		queue_free()
	dialog_index += 1
