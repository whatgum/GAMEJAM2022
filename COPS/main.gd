extends Control

var evidenceScene = load("res://evidenceScene.tscn")

var amtOfAbuse = 0
var amtOfPersuasion = 0
var amtOfEvidence = 0
var verdict = "UNDECIDED"


func _on_questioning_start_abuse():
	get_child(4).init()
	get_child(2).visible = false
	amtOfAbuse += 1


func _on_questioning_startcohersion():
	get_child(1).visible = true
	get_child(2).visible = false
	get_child(1).startGame()
	amtOfPersuasion += 1


func _on_abuse_comes_cheap_abuse_minigame_finished(won):
	get_child(4).visible = false
	get_child(2).visible = true
	if(won):
		get_child(2).successful_minigame()
	print("returned minigame")


func _on_rich_text_label_game_over(won):
	get_child(2).visible = false
	get_child(1).visible = false
	get_child(4).visible = false
	get_child(3).visible = false
	get_child(5).visible = false
	lawyeredUp()


func _on_questioning_out_of_questions():
	get_child(2).visible = false
	get_child(3).visible = true
	initScales()


func initScales():
	var array = []
	for i in get_child(2).get_child(3).get_child(0).get_child(0).get_children():
		var newEvidence = evidenceScene.instantiate()
		newEvidence.init(i._texture,i._text, i._text2)
		array.append(newEvidence)
		amtOfEvidence += 1
	get_child(3).init(array)


func _on_coersion_minigame_coersion_minigame_finished(won):
	get_child(1).visible = false
	get_child(2).visible = true
	if(won):
		get_child(2).successful_minigame()
	print("returned minigame")


func lawyeredUp():
	get_child(6).visible = true
	get_child(6).init2([amtOfEvidence, amtOfAbuse, amtOfPersuasion], verdict)


func _on_scales_of_justice_judgement(_verdict):
	verdict = _verdict
	get_child(5).get_child(0).game_over = true
	get_child(5).visible = false
	get_child(6).init([amtOfEvidence, amtOfAbuse, amtOfPersuasion], verdict)
	get_child(6).visible = true
