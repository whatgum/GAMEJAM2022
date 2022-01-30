extends Control

var evidenceBlock = load("res://evidenceBlock.tscn")

var amtOfEvidnece = -1
# Called when the node enters the scene tree for the first time.
func init(arrayOfEvidence : Array):
	if(amtOfEvidnece == -1):
		amtOfEvidnece = arrayOfEvidence.size()
	for i in arrayOfEvidence:
		var newBlock = evidenceBlock.instantiate()
		newBlock.init(i._texture, i._text, i._text2)
		get_child(1).add_child(newBlock)
		newBlock.global_position = get_child(4).global_position

func _process(delta):
	if(amtOfEvidnece == get_child(6).evidencesOnMe.size() + get_child(7).evidencesOnMe.size()):
		get_child(10).visible = true
	else:
		get_child(10).visible = false
