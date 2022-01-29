extends Control

var currentEvidence = ""

func _process(delta):
	if(Input.is_action_just_pressed("removeEvidence")):
		print("pressed button")
		Input.set_custom_mouse_cursor(null)
		currentEvidence = ""

func _on_button_pressed():
	if(currentEvidence != ""):
		print("Ask about : " + currentEvidence)
	Input.set_custom_mouse_cursor(null)
