extends Control

var currentEvidence = ""
var currentQuestion = ""

var texture = load("res://icon.png")
signal startConversation(detectiveDict, interviewDict, key)
signal pressAtEnd()
signal addQuestion(question, pressable)
signal addEvidence(texture,title, description)
signal startAbuse
signal startcohersion

func _process(delta):
	if(Input.is_action_just_pressed("removeEvidence")):
		print("pressed button")
		Input.set_custom_mouse_cursor(null)
		currentEvidence = ""


func _on_button_pressed():
	if(currentEvidence != ""):
		_on_question_container_start_dialogue(currentEvidence, false)
	Input.set_custom_mouse_cursor(null)

# Purpose : This dictionary uses questions asked as keys
#			as values it holds arrays consisting of 2 dictionaries
#			These dictionaries are the detective and Interviewee dialogue respectively
#			The keys are dialgoues already said and the values are their responses to them
var ConversationDictionary := {
	"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : [{"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : "Whats all this about a fox??"},{"Whats all this about a fox??" : "yeah it was a fox, I swear"}]}


# Purpose : This dictionary uses questions asked as keys
#			as values it holds arrays consisting of arrays
#			These inner arrays stores questions to be asked and whether said question is pressable
# 			These inner arrays are used to create new question scenes for the player to ask
var questionDictioary := {
	"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : [["question?", false], ["whats a question", true]]
}

# Purpose : This dictionary uses questions asked as keys
#			as values it holds arrays consisting of arrays
#			these inner arrays stores evidence texture, the title of evidence and the description of evidence
#			These inner arrays are used to create new evidence scenes for the player to view
var evidenceDictionary := {
	"THE QUICK BROWN FOX JUMPS OVER THE SMALL DOG?" : 
		[[texture,"I think that I love you", "The mater of love is not a trival thing. But they professed it to you."]]
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
	if(evidenceDictionary.has(currentQuestion)):
		var arrayOfEvidence = evidenceDictionary[currentQuestion]
		for i in arrayOfEvidence:
			emit_signal("addEvidence", i[0], i[1], i[2])
		arrayOfEvidence.erase(currentQuestion)


func _on_abuse_pressed():
	emit_signal("startAbuse")


func _on_coherse_pressed():
	emit_signal("startCohersion")
