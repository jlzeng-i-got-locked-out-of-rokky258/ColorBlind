extends Control


func _ready():
	pass


func _process(delta):
	$DeathCount.bbcode_text = "DEATHS: " + str(Global.getDeaths())
	$Timer.bbcode_text = "[center]" + Global.getTimeString()
	$ScoreCount.bbcode_text = "[right]SCORE: " + str(Global.getScore())
