extends RichTextLabel

var time := 30.00

signal gameOver(won)

func _process(delta):
	if(time > 0.0):
		time -= delta
		self.text = "TIME LEFT :" + String.num(time, 2)
	else:
		emit_signal("gameOver", false)
		self.text = "[center]TIMES UP!"
