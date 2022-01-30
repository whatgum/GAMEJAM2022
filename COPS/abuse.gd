extends Control

signal abuse_minigame_finished(won)

var won = false
var alreadyPressed = false
func _ready():
	get_child(0).game_over = true
	get_child(0).value = 100
	get_child(4).visible = false
	get_child(2).gameOver = true
	get_child(1).get_child(0).game_over = true



# Called when the node enters the scene tree for the first time.
func init():
	won = false
	get_child(3).start()
	get_child(1).get_child(0).time = 30.00
	get_child(2).gameOver = false
	get_child(0).game_over = false
	self.visible = true
	get_child(1).get_child(0).game_over = false
	alreadyPressed = false

func gameOver(won : bool):
	get_child(3).stop()
	get_child(2).gameOver = true
	get_child(0).game_over = true
	get_child(1).get_child(0).game_over = true
	if(won):
		get_child(4).get_child(0).get_child(0).text = "[center]You managed to get him talking"
		won = true
	else:
		get_child(4).get_child(0).get_child(0).text = "[center]You couldn't get him to talk..."
	get_child(4).popup_centered(Vector2i(400,200))


func _on_button_pressed():
	if(!alreadyPressed):
		alreadyPressed = true
		self.visible = false
		get_child(0).game_over = false
		get_child(0).value = 100
		get_child(4).visible = false
		get_child(2).gameOver = false
		emit_signal("abuse_minigame_finished", won)


func _on_popup_popup_hide():
	if(!alreadyPressed):
		_on_button_pressed()
