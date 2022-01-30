extends Control

var evidenceScene = load("res://evidenceScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_questioning_start_abuse():
	get_child(4).init()
	get_child(2).visible = false

func _on_questioning_startcohersion():
	get_child(1).visible = true
	get_child(2).visible = false
	get_child(1).init()


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
	get_child(3).visible = true
	initEndGame()

func _on_questioning_out_of_questions():
	get_child(2).visible = false
	get_child(3).visible = true
	initEndGame()
	
func initEndGame():
	var array = []
	for i in get_child(2).get_child(3).get_child(0).get_child(0).get_children():
		var newEvidence = evidenceScene.instantiate()
		newEvidence.init(i._texture,i._text, i._text2)
		array.append(newEvidence)
	get_child(3).init(array)
