extends Control


func _process(delta):
	if(Input.is_action_just_pressed("removeEvidence")):
		print("pressed button")
		Input.set_custom_mouse_cursor(null)
