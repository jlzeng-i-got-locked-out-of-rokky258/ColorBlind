extends ColorRect


signal fade_finished

func fade_in():
	$AnimationPlayer.play("Fade IN")
	
func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("fade_finished")
