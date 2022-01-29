extends VBoxContainer

var question = load("res://questionScene.tscn") 
# Called when the node enters the scene tree for the first time.

signal pressThisBitch(string)

signal startDialogue(string)

var currentIndex : int

func passQuestion(string : String, pressable : bool) -> void:
	var newQuestion = question.instantiate();
	print("NQ", string)
	newQuestion.init(string, pressable)
	self.add_child(newQuestion)


func sendQuestion(string : String, pressable : bool, index : int) -> void: 
	if(string.begins_with("[center]")):
		string = string.substr(8)
	print("ask this : " + string)
	if(pressable):
		print("press this bitch")
		emit_signal("startDialogue", string, pressable)
		currentIndex = index
	else:
		print("just do dialogue")
		self.remove_child(get_child(index))
		emit_signal("startDialogue", string, pressable)
	get_tree().call_group("questions", "disableButtons", true)
