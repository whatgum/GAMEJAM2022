extends Control

enum varients{DETECTIVE, INTERVEIWEE}
var detecDic : Dictionary
var interDic : Dictionary
var key : String
var dialogPop = load("res://DialogPopup.tscn")
var rectSize = Vector2(512, 90)

var detecColor = Color("cc846f")
var interColor = Color("73b86a")

func initDialog(detecitveDialogue : Dictionary, intervieweeDialogue : Dictionary, _key : String) -> void:
	print('startingDialog')
	self.detecDic = detecitveDialogue
	self.interDic = intervieweeDialogue
	self.key = _key
	if(detecDic.has(key)):
		setUpPopup(varients.DETECTIVE, detecDic[key])
	if(interDic.has(key)):
		setUpPopup(varients.INTERVEIWEE, interDic[key])


func setUpPopup(varient : int, dialogue : String) -> void:
	var newPop : RichTextLabel
	newPop = dialogPop.instantiate()
	
	dialogue = "[center]" + dialogue
	newPop.text = dialogue

	newPop.connect("finishedDialgue", Callable(self, "startNext"))
	match(varient):
		varients.DETECTIVE:
			get_child(1).add_child(newPop)
		varients.INTERVEIWEE:
			get_child(0).add_child(newPop)
	newPop.rect_size = rectSize

func startNext(newKey : String) -> void:
	self.key = newKey
	print(key)
	if(detecDic.has(key)):
		setUpPopup(varients.DETECTIVE, detecDic[key])
	elif(interDic.has(key)):
		setUpPopup(varients.INTERVEIWEE, interDic[key])
	else:
		get_tree().call_group("questions", "disableButtons", false)
