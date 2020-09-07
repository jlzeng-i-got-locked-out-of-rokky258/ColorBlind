extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	$DeathCount.bbcode_text = "DEATHS: " + str(Global.getDeaths())
	$ScoreCount.bbcode_text = "[right]SCORE: " + str(Global.getScore())
