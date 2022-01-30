extends Control

enum varients{DETECTIVE, INTERVEIWEE}
var detecDic : Dictionary
var interDic : Dictionary
var key : String
var dialogPop = load("res://DialogPopup.tscn")
var rectSize = Vector2(512, 90)
var pressable = false
var detecColor = Color("cc846f")
var interColor = Color("73b86a")

signal showPopup
signal addQuestions
signal startTalking
signal stopTalking

func initDialog(detecitveDialogue : Dictionary, intervieweeDialogue : Dictionary, _key : String) -> void:
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
	get_bbcode_color_tag

	newPop.connect("finishedDialgue", Callable(self, "startNext"))
	match(varient):
		varients.DETECTIVE:
			get_child(1).add_child(newPop)
			dialogue = get_bbcode_color_tag(detecColor) + dialogue
			emit_signal("stopTalking")
		varients.INTERVEIWEE:
			get_child(0).add_child(newPop)
			dialogue = get_bbcode_color_tag(interColor) + dialogue
			emit_signal("startTalking")
	newPop.text = dialogue
	newPop.rect_size = rectSize


func startNext(newKey : String) -> void:
	self.key = newKey
	if(detecDic.has(key)):
		setUpPopup(varients.DETECTIVE, detecDic[key])
	elif(interDic.has(key)):
		setUpPopup(varients.INTERVEIWEE, interDic[key])
	else:
		if(pressable):
			pressable = false
			emit_signal("showPopup")
		else:
			get_tree().call_group("questions", "disableButtons", false)
			emit_signal("addQuestions")
		emit_signal("stopTalking")

func _on_questioning_press_at_end():
	pressable = true


func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"
