extends RichTextLabel

var time := 30.00

signal gameOver(won)

var game_over = false
func _process(delta):
	if(time > 0.0 && game_over != true):
		time -= delta
		self.text = "TIME LEFT :" + String.num(time, 2)
	if(time < 0.0 && game_over == false):
		emit_signal("gameOver", false)
		self.text = "[center]TIMES UP!"
		game_over = true
