extends Control

var currentEvidence = ""
var currentQuestion = ""
signal startConversation(detectiveDict, interviewDict, key)
signal pressAtEnd()
signal addQuestion(question, pressable)

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


var questionDictioary := {
	"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : [["question?", false], ["whats a question", true]]
}


func _on_question_container_start_dialogue(key : String, pressable : bool):
	key = key.to_upper()
	currentQuestion = key
	print(key)
	if(ConversationDictionary.has(key)):
		if(pressable):
			emit_signal("pressAtEnd")
		emit_signal("startConversation", ConversationDictionary[key][0], ConversationDictionary[key][1], key )


func _on_dialog_manager_add_questions():
	if(questionDictioary.has(currentQuestion)):
		var arrayOfQuestions = questionDictioary[currentQuestion]
		for i in arrayOfQuestions:
			emit_signal("addQuestion",i[0], i[1])
		questionDictioary.erase(currentQuestion)
