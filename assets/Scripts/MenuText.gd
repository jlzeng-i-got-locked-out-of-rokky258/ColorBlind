extends RichTextLabel
var storedText = "START"

func _ready():
	bbcode_text = "[center]"+ storedText + "[/center]"
func _on_Label_mouse_entered():
	bbcode_text = "[center][wave]"+ storedText + "[/wave][/center]"


func _on_Label_mouse_exited():
	bbcode_text = "[center]"+ storedText + "[/center]"
