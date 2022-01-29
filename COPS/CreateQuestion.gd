extends VBoxContainer

var question = load("res://questionScene.tscn") 
# Called when the node enters the scene tree for the first time.

signal pressThisBitch(string)

signal startDialogue(string)

func passQuestion(string : String, pressable : bool) -> void:
	var newQuestion = question.instance();
	newQuestion.init(string, pressable)
	self.add_child(newQuestion)


func sendQuestion(string : String, pressable : bool, index : int) -> void: 
	if(string.begins_with("[center]")):
		string = string.substr(8)
	print("ask this : " + string)
	if(pressable):
		print("press this bitch")
		emit_signal("pressThisBitch", string)
	else:
		print("just do dialogue")
		self.remove_child(get_child(index))
		emit_signal("startDialogue", string)
	get_tree().call_group("questions", "disableButtons", true)
