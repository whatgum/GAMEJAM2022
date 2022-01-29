extends VBoxContainer

var question = load("res://questionScene.tscn") 
# Called when the node enters the scene tree for the first time.
func passQuestion(string : String) -> void:
	var newQuestion = question.instance();
	newQuestion.init(string)
	self.add_child(newQuestion)
