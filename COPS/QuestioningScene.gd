extends Control

var currentEvidence = ""
signal startConversation(detectiveDict, interviewDict, key)

func _process(delta):
	if(Input.is_action_just_pressed("removeEvidence")):
		print("pressed button")
		Input.set_custom_mouse_cursor(null)
		currentEvidence = ""


func _on_button_pressed():
	if(currentEvidence != ""):
		print("Ask about : " + currentEvidence)
	Input.set_custom_mouse_cursor(null)


var ConversationDictionary := {
	"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : [{"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : "Whats all this about a fox??"},{"Whats all this about a fox??" : "yeah it was a fox, I swear"}]}


func _on_question_container_start_dialogue(key : String):
	key = key.to_upper()
	print(key)
	if(ConversationDictionary.has(key)):
		emit_signal("startConversation", ConversationDictionary[key][0], ConversationDictionary[key][1], key )
