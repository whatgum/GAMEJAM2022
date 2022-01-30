extends Control

var currentEvidence = ""
var currentQuestion = ""

var texture = load("res://icon.png")
signal startConversation(detectiveDict, interviewDict, key)
signal pressAtEnd()
signal addQuestion(question, pressable)
signal addEvidence(texture,title, description)


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
	"INTRODUCE YOURSELVES TO THE SUSPECT" : [
		{"INTRODUCE YOURSELVES TO THE SUSPECT" : "Hi, I'm Detective Chuck Findout and this is my partner, Donald P. Violence."},
		{"Hi, I'm Detective Chuck Findout and this is my partner, Donald P. Violence." : "Uh, no offense fellas, but I'd rather just wait for my lawyer..."}],
	"DO YOU KNOW WHY YOU'RE HERE?" : [
		{"DO YOU KNOW WHY YOU'RE HERE?" : "Are you aware of why we brought you into the station today?"},
		{"Are you aware of why we brought you into the station today?" : "No. Listen, I just wanna wait for my lawyer"}],
	"A CERTAIN SOMETHING WENT MISSING LAST NIGHT..." : [
		{"A CERTAIN SOMETHING WENT MISSING LAST NIGHT..." : "We got reports of theft late last night. Witnesses say they saw you."},
		{"We got reports of theft late last night. Witnesses say they saw you." : "What?? No, listen, you got the wrong guy! I'm an accountant!"}],
	"WHAT'S YOUR ALIBI?" : [
		{"WHAT'S YOUR ALIBI?" : "So I take it you were nowhere near 340 8th street last night between 7 and 9 PM?"},
		{"So I take it you were nowhere near 340 8th street last night between 7 and 9 PM?" : "What? That's-... No, no I wasn't! And that's none of your business!"}],
	"SAYS HERE YOU'VE GOT HISTORY WITH THE CRIME SCENE. WANNA EXPLAIN?" : [
		{"SAYS HERE YOU'VE GOT HISTORY WITH THE CRIME SCENE. WANNA EXPLAIN?" : "Says here you were detained at the scene of the crime 8 months ago. Spill it."},
		{"Says here you were detained at the scene of the crime 8 months ago. Spill it." : "What?! That's insanity! There must be some mistake, it's not true!"}],
	"HOW DO YOU LIKE THE STATION? COMFORTABLE?" : [
		{"HOW DO YOU LIKE THE STATION? COMFORTABLE?" : "How do you like the station? Comfortable?"},
		{"How do you like the station? Comfortable?" : "No, actually. This interrogation room is really small and smells like... chili dogs"}],
	"ONE MORE TIME: WHAT HAPPENED AT THE BOWLING ALLEY?" : [
		{"ONE MORE TIME: WHAT HAPPENED AT THE BOWLING ALLEY?" : "I'm gonna ask again, what went down that night at the bowling alley?"},
		{"I'm gonna ask again, what went down that night at the bowling alley?" : "Ok, ok! But it's not what you think! Some weirdo just yelled at me because I 'took too much nacho cheese' or something!"}],
	"DO YOU THINK IT'S OK TO HOG THE NACHO CHEESE?" : [
		{"DO YOU THINK IT'S OK TO HOG THE NACHO CHEESE?" : "So sickos like you just get off on taking nacho cheese from hardworking Americans, huh?"},
		{"So sickos like you just get off on taking from hardworking Americans, huh?" : "I- what? No, I mean- Listen, this is completely off subject!"}],
	"PRESENT HIM WITH AN EYEWITNESS SKETCH OF THE SUSPECT" : [
		{"PRESENT HIM WITH AN EYEWITNESS SKETCH OF THE SUSPECT" : "(You uncrumple a sketch and lay it on the table. It is in crayon.) Look familiar?"},
		{"(You uncrumple a sketch and lay it on the table. It is in crayon.) Look familiar?" : "What?? That doesn't look like me! I mean c'mon!! Did you make that just now??"}],
	"CONFRONT WTIH ACCUSAL" : [
		{"CONFRONT WITH ACCUSAL" : "Let's stop playing games. Last night, you totally drained the nacho machine. Dry nachos from 7 PM on. Barely even warm."},
		{"Let's stop playing games. Last night, you totally drained the nacho machine. Dry nachos from 7 PM on. Barely even warm." : "What?!? That?!? I mean, no!! I wouldn't! I'm not that GUY anymore!"}],
	"WALK HIM THROUGH THE CRIME" : [
		{"WALK HIM THROUGH THE CRIME" : "You kept filling your nacho bin time after time, and eventually the well dried up, didn't it?"},
		{"You kept filling your nacho bin time after time, and eventually the well dried up, didn't it?" : "No! You've got no proof! And even if I did do it, I wouldn't even care, because the nacho cheese here SUCKS anyway!"}],
	"PRESENT YOUR FACTS LOGICALLY" : [
		{"PRESENT YOUR FACTS LOGICALLY" : "AAEEEEUUUUUUGGGHHHHHHHHHHHHHHHHHHHHOOOOOOOOOOOOOOOHHHHHHHHHHHH YOU [b]FUCKER![/b] I'LL KILL YOU!"},
		{"AAEEEEUUUUUUGGGHHHHHHHHHHHHHHHHHHHHOOOOOOOOOOOOOOOOOOHHHHHHHHHHHH YOU [b]FUCKER![/b] I'LL KILL YOU!" : "SEE YOU'VE GOT *RULES*! ME? I'VE GOT NO RULES! YOU'LL NEVER HAVE ANYTHING ON A GUY LIKE ME!!"}]}


# Purpose : This dictionary uses questions asked as keys
#			as values it holds arrays consisting of arrays
#			These inner arrays stores questions to be asked and whether said question is pressable
# 			These inner arrays are used to create new question scenes for the player to ask
var questionDictioary := {
	"INTRODUCE YOURSELVES TO THE SUSPECT" : [["DO YOU KNOW WHY YOU'RE HERE?", false]],
	"DO YOU KNOW WHY YOU'RE HERE?" : [["A CERTAIN SOMETHING WENT MISSING LAST NIGHT...", false]],
	"A CERTAIN SOMETHING WENT MISSING LAST NIGHT..." : [["WHAT'S YOUR ALIBI?", true], 
												["SAYS HERE YOU'VE GOT HISTORY WITH THE CRIME SCENE. WANNA EXPLAIN?", true],
												["HOW DO YOU LIKE THE STATION? COMFORTABLE?", true]],
	"CONFESSION: DARK PAST" : [["ONE MORE TIME: WHAT HAPPENED AT THE BOWLING ALLEY?", false]],
	"ONE MORE TIME: WHAT HAPPENED AT THE BOWLING ALLEY?" : [["DO YOU THINK IT'S OK TO HOG THE NACHO CHEESE?", true]],
	"DO YOU THINK IT'S OK TO HOG THE NACHO CHEESE?" :  [["PRESENT HIM WITH AN EYEWITNESS SKETCH OF THE SUSPECT", true],
													["CONFRONT WITH ACCUSAL", false]],
	"CONFRONT WITH ACCUSAL" : [["WALK HIM THROUGH THE CRIME", false]],
	"WALK HIM THROUGH THE CRIME" : [["PRESENT YOUR FACTS LOGICALLY", true]]
}

# Purpose : This dictionary uses questions asked as keys
#			as values it holds arrays consisting of arrays
#			these inner arrays stores evidence texture, the title of evidence and the description of evidence
#			These inner arrays are used to create new evidence scenes for the player to view
var evidenceDictionary := {
	"CONFESSION: WHEREABOUTS" : 
		[[texture,"Confession: Whereabouts", "He admitted he was near the address of the crime"]],
	"CONFESSION: DARK PAST" :
		[[texture, "Confession: Dark Past", "He's got a record at this address. Got into an altercation with 'Bowling Staff', so he says"]],
	"ADMISSION: COMFORTABLE" :
		[[texture, "Admission: Comfortable", "At first, he said he wasn't comfy- but with some convincing he changed his mind. What else is he hiding?"]],
	"ADMISSION: MORALLY BANKRUPT" :
		[[texture, "Admission: Morally Bankrupt", "He feels no remorse no matter whose lives he destroys. No matter how much cheese he hogs."]],
	"ADMISSION: SKETCH RESEMBLENCE" :
		[[texture, "Admission: Sketch Resemblence", "Artists work in many mediums, this one just happens to be crayon. It does look like him, though."]],
	"MENTAL STATE: FULL-ON VILLAIN" :
		[[texture, "Mental State: Full-On Villain", "By pushing him to his very limits, he seems to have gone into what psychologists call a 'Joker State'."]]
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
