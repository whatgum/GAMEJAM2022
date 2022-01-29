extends Control

var evidenceBlock = load("res://evidenceBlock.tscn")

# Called when the node enters the scene tree for the first time.
func init(arrayOfEvidence : Array):
	for i in arrayOfEvidence:
		var newBlock = evidenceBlock.instantiate()
		newBlock.init(i._texture, i._text, i._text2)
		get_child(1).add_child(newBlock)
		newBlock.global_position = get_child(3).global_position

